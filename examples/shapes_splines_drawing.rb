# coding: utf-8
require_relative 'util/setup_dll'
require_relative 'util/resource_path'

MAX_SPLINE_POINTS = 32

class ControlPoint
  attr_accessor :start, :end
  def initialize
    @start = Vector3.new
    @end = Vector3.new
  end
end

SPLINE_LINEAR = 0     # Linear
SPLINE_BASIS = 1      # B-Spline
SPLINE_CATMULLROM = 2 # Catmull-Rom
SPLINE_BEZIER = 3     # Cubic Bezier

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450
  SetConfigFlags(FLAG_MSAA_4X_HINT)
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - splines drawing")
  SetTargetFPS(60)

  points = [
    Vector2.create(  50.0, 400.0 ),
    Vector2.create( 160.0, 220.0 ),
    Vector2.create( 340.0, 380.0 ),
    Vector2.create( 520.0, 60.0 ),
    Vector2.create( 710.0, 260.0 ),
  ]

  selectedPoint = -1
  focusedPoint = -1
  selectedControlPoint = nil
  focusedControlPoint = nil

  pointsBuffer = FFI::MemoryPointer.new(FFI::NativeType::FLOAT32.size * (2 * MAX_SPLINE_POINTS))

  control = Array.new (MAX_SPLINE_POINTS) { ControlPoint.new }

  update_points = lambda {
    pointsBuffer.put_array_of_float32(0, points.map{|p| p.to_a}.flatten!)
    # Cubic Bezier control points initialization
    (points.length - 1).times do |i|
      control[i].start = Vector2.create(points[i].x + 50, points[i].y)
      control[i].end = Vector2.create(points[i + 1].x - 50, points[i + 1].y)
    end
  }
  update_points.call

  # Spline config variables
  splineThickness = 8.0
  splineTypeActive = SPLINE_LINEAR # 0-Linear, 1-BSpline, 2-CatmullRom, 3-Bezier
  splineTypeEditMode = false
  splineHelpersActive = true

  SetTargetFPS(60)

  until WindowShouldClose()
    currentMousePosition = GetMousePosition()
    # Spline points creation logic (at the end of spline)
    if IsMouseButtonPressed(MOUSE_BUTTON_RIGHT) && (points.length < MAX_SPLINE_POINTS)
      points << currentMousePosition
      update_points.call
    end

    # Spline point focus and selection logic
    points.length.times do |i|
      if CheckCollisionPointCircle(currentMousePosition, points[i], 8.0)
        focusedPoint = i
        if IsMouseButtonDown(MOUSE_BUTTON_LEFT)
          selectedPoint = i
          break
        end
      else
        focusedPoint = -1
      end
    end

    # Spline point movement logic
    if selectedPoint >= 0
      points[selectedPoint] = currentMousePosition
      update_points.call
      selectedPoint = -1 if IsMouseButtonReleased(MOUSE_BUTTON_LEFT)
    end

    # Cubic Bezier spline control points logic
    if (splineTypeActive == SPLINE_BEZIER) && (focusedPoint == -1)
      # Spline control point focus and selection logic
      points.length.times do |i|
        if CheckCollisionPointCircle(currentMousePosition, control[i].start, 6.0)
          focusedControlPoint = control[i].start
          selectedControlPoint = control[i].start if IsMouseButtonDown(MOUSE_BUTTON_LEFT)
          break
        elsif CheckCollisionPointCircle(currentMousePosition, control[i].end, 6.0)
          focusedControlPoint = control[i].end
          selectedControlPoint = control[i].end if IsMouseButtonDown(MOUSE_BUTTON_LEFT)
          break
        else
          focusedControlPoint = nil
        end

        # Spline control point movement logic
        if selectedControlPoint != nil
          selectedControlPoint.set(currentMousePosition.x, currentMousePosition.y)
          selectedControlPoint = nil if IsMouseButtonReleased(MOUSE_BUTTON_LEFT)
        end
      end
    end

    # Spline selection logic
    splineTypeActive = if IsKeyPressed(KEY_ONE)
                         SPLINE_LINEAR
                       elsif IsKeyPressed(KEY_TWO)
                         SPLINE_BASIS
                       elsif IsKeyPressed(KEY_THREE)
                         SPLINE_CATMULLROM
                       elsif IsKeyPressed(KEY_FOUR)
                         SPLINE_BEZIER
                       else
                         splineTypeActive
                       end

    BeginDrawing()
      ClearBackground(RAYWHITE)
      case splineTypeActive
      when SPLINE_LINEAR
        DrawSplineLinear(pointsBuffer, points.length, splineThickness, RED)
      when SPLINE_BASIS
        DrawSplineBasis(pointsBuffer, points.length, splineThickness, RED) # Provide connected points array
      when SPLINE_CATMULLROM
        DrawSplineCatmullRom(pointsBuffer, points.length, splineThickness, RED) # Provide connected points array
      when SPLINE_BEZIER
        # Draw spline: cubic-bezier (with control points)
        (points.length - 1).times do |i|
          # Drawing individual segments, not considering thickness connection compensation
          DrawSplineSegmentBezierCubic(points[i], control[i].start, control[i].end, points[i + 1], splineThickness, RED)
          # Every cubic bezier point should have two control points
          DrawCircleV(control[i].start, 6, GOLD)
          DrawCircleV(control[i].end, 6, GOLD)
          if focusedControlPoint == control[i].start
            DrawCircleV(control[i].start, 8, GREEN)
          elsif focusedControlPoint == control[i].end
            DrawCircleV(control[i].end, 8, GREEN)
          end
          DrawLineEx(points[i], control[i].start, 1.0, LIGHTGRAY)
          DrawLineEx(points[i + 1], control[i].end, 1.0, LIGHTGRAY)

          # Draw spline control lines
          DrawLineV(points[i], control[i].start, GRAY)
          DrawLineV(control[i].end, points[i + 1], GRAY)
        end
      end

      if splineHelpersActive
        # Draw spline point helpers
        points.length.times do |i|
          DrawCircleLinesV(points[i], (focusedPoint == i) ? 12.0 : 8.0, (focusedPoint == i) ? BLUE : DARKBLUE)
          if ((splineTypeActive != SPLINE_LINEAR) &&
              (splineTypeActive != SPLINE_BEZIER) &&
              (i < points.length - 1))
            DrawLineV(points[i], points[i + 1], GRAY)
          end
          DrawText(TextFormat("[%.0f, %.0f]", :float, points[i].x, :float, points[i].y), points[i].x, points[i].y + 10, 10, BLACK)
        end
      end

      # Check all possible UI states that require controls lock
      GuiLock() if splineTypeEditMode
      # Draw spline config
      GuiLabel(Rectangle.create(12, 62, 140, 24), "Spline thickness: #{splineThickness.to_i}")
      splineThickness, result = RGuiSliderBar(Rectangle.create(12, 60 + 24, 140, 16), nil, nil, splineThickness, 1.0, 40.0)

      splineHelpersActive, result = RGuiCheckBox(Rectangle.create(12, 110, 20, 20), 'Show point helpers', splineHelpersActive)
      GuiUnlock()

      GuiLabel(Rectangle.create(12, 10, 140, 24), "Spline type:")

      splineTypeActive, result = RGuiDropdownBox(Rectangle.create(12, 8 + 24, 140, 28), "LINEAR;BSPLINE;CATMULLROM;BEZIER", splineTypeActive, splineTypeEditMode)
      splineTypeEditMode = !splineTypeEditMode if result != 0
    EndDrawing()
  end

  CloseWindow()
end
