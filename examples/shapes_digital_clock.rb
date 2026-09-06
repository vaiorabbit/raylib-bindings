require_relative 'util/setup_dll'

CLOCK_ANALOG = 0
CLOCK_DIGITAL = 1

class ClockHand
  attr_accessor :value, :angle, :length, :thickness, :color

  def initialize(angle:, length:, thickness:, color:)
    @value = 0
    @angle = angle
    @length = length
    @thickness = thickness
    @color = color
  end
end

class Clock
  attr_reader :second, :minute, :hour

  def initialize
    @second = ClockHand.new(angle: 45, length: 140, thickness: 3, color: MAROON)
    @minute = ClockHand.new(angle: 10, length: 130, thickness: 7, color: DARKGRAY)
    @hour = ClockHand.new(angle: 0, length: 100, thickness: 7, color: BLACK)
  end
end

def update_clock(clock)
  now = Time.now

  clock.second.value = now.sec
  clock.minute.value = now.min
  clock.hour.value = now.hour

  clock.hour.angle = (now.hour % 12) * 30.0 + (now.min % 60) * 30.0 / 60.0 - 90
  clock.minute.angle = (now.min % 60) * 6.0 + (now.sec % 60) * 6.0 / 60.0 - 90
  clock.second.angle = (now.sec % 60) * 6.0 - 90
end

def draw_clock_analog(clock, position)
  DrawCircleV(position, clock.second.length + 40.0, LIGHTGRAY)
  DrawCircleV(position, 12.0, GRAY)

  60.times do |i|
    angle = (6.0 * i - 90.0) * DEG2RAD
    outer_length = clock.second.length + ((i % 5).zero? ? 6 : 10)
    DrawLineEx(
      Vector2.create(position.x + outer_length * Math.cos(angle), position.y + outer_length * Math.sin(angle)),
      Vector2.create(position.x + (clock.second.length + 20) * Math.cos(angle), position.y + (clock.second.length + 20) * Math.sin(angle)),
      (i % 5).zero? ? 3.0 : 1.0,
      DARKGRAY
    )
  end

  [clock.second, clock.minute, clock.hour].each do |hand|
    DrawRectanglePro(
      Rectangle.create(position.x, position.y, hand.length.to_f, hand.thickness.to_f),
      Vector2.create(0.0, hand.thickness / 2.0),
      hand.angle,
      hand.color
    )
  end
end

def draw_clock_digital(clock, position)
  color_on = RED
  color_off = Fade(LIGHTGRAY, 0.3)

  draw_display_value(Vector2.create(position.x, position.y), clock.hour.value / 10, color_on, color_off)
  draw_display_value(Vector2.create(position.x + 120, position.y), clock.hour.value % 10, color_on, color_off)

  blink_color = (clock.second.value % 2).positive? ? color_on : color_off
  DrawCircle(position.x.to_i + 240, position.y.to_i + 70, 12, blink_color)
  DrawCircle(position.x.to_i + 240, position.y.to_i + 150, 12, blink_color)

  draw_display_value(Vector2.create(position.x + 260, position.y), clock.minute.value / 10, color_on, color_off)
  draw_display_value(Vector2.create(position.x + 380, position.y), clock.minute.value % 10, color_on, color_off)

  DrawCircle(position.x.to_i + 500, position.y.to_i + 70, 12, blink_color)
  DrawCircle(position.x.to_i + 500, position.y.to_i + 150, 12, blink_color)

  draw_display_value(Vector2.create(position.x + 520, position.y), clock.second.value / 10, color_on, color_off)
  draw_display_value(Vector2.create(position.x + 640, position.y), clock.second.value % 10, color_on, color_off)
end

def draw_display_value(position, value, color_on, color_off)
  segments = [0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110,
              0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111][value]
  draw_7_segment_display(position, segments, color_on, color_off) unless segments.nil?
end

def draw_7_segment_display(position, segments, color_on, color_off)
  segment_length = 60
  segment_thickness = 20
  offset_y = segment_thickness * 0.3
  segment = lambda do |x, y, vertical, bit|
    draw_display_segment(Vector2.create(x, y), segment_length, segment_thickness, vertical,
                         (segments & bit).positive? ? color_on : color_off)
  end

  segment.call(position.x + segment_thickness + segment_length / 2.0, position.y + segment_thickness, false, 0b00000001)
  segment.call(position.x + segment_thickness + segment_length + segment_thickness / 2.0,
              position.y + 2 * segment_thickness + segment_length / 2.0 - offset_y, true, 0b00000010)
  segment.call(position.x + segment_thickness + segment_length + segment_thickness / 2.0,
              position.y + 4 * segment_thickness + segment_length + segment_length / 2.0 - 3 * offset_y, true, 0b00000100)
  segment.call(position.x + segment_thickness + segment_length / 2.0,
              position.y + 5 * segment_thickness + 2 * segment_length - 4 * offset_y, false, 0b00001000)
  segment.call(position.x + segment_thickness / 2.0,
              position.y + 4 * segment_thickness + segment_length + segment_length / 2.0 - 3 * offset_y, true, 0b00010000)
  segment.call(position.x + segment_thickness / 2.0,
              position.y + 2 * segment_thickness + segment_length / 2.0 - offset_y, true, 0b00100000)
  segment.call(position.x + segment_thickness + segment_length / 2.0,
              position.y + 3 * segment_thickness + segment_length - 2 * offset_y, false, 0b01000000)
end

def draw_display_segment(center, length, thickness, vertical, color)
  if vertical
    points = [
      [center.x, center.y - length / 2.0 - thickness / 2.0],
      [center.x - thickness / 2.0, center.y - length / 2.0],
      [center.x + thickness / 2.0, center.y - length / 2.0],
      [center.x - thickness / 2.0, center.y + length / 2.0],
      [center.x + thickness / 2.0, center.y + length / 2.0],
      [center.x, center.y + length / 2.0 + thickness / 2.0]
    ]
  else
    points = [
      [center.x - length / 2.0 - thickness / 2.0, center.y],
      [center.x - length / 2.0, center.y + thickness / 2.0],
      [center.x - length / 2.0, center.y - thickness / 2.0],
      [center.x + length / 2.0, center.y + thickness / 2.0],
      [center.x + length / 2.0, center.y - thickness / 2.0],
      [center.x + length / 2.0 + thickness / 2.0, center.y]
    ]
  end

  points_buffer = FFI::MemoryPointer.new(FFI::NativeType::FLOAT32.size * points.flatten.length)
  points_buffer.put_array_of_float32(0, points.flatten)
  DrawTriangleStrip(points_buffer, points.length, color)
end

if __FILE__ == $PROGRAM_NAME
  screen_width = 800
  screen_height = 450

  SetConfigFlags(FLAG_MSAA_4X_HINT)
  InitWindow(screen_width, screen_height, 'raylib [shapes] example - digital clock')

  clock_mode = CLOCK_DIGITAL
  clock = Clock.new
  SetTargetFPS(60)

  until WindowShouldClose()
    if IsKeyPressed(KEY_SPACE)
      clock_mode = clock_mode == CLOCK_DIGITAL ? CLOCK_ANALOG : CLOCK_DIGITAL
    end

    update_clock(clock)

    BeginDrawing()
      ClearBackground(RAYWHITE)

      if clock_mode == CLOCK_ANALOG
        draw_clock_analog(clock, Vector2.create(400, 240))
      else
        draw_clock_digital(clock, Vector2.create(30, 60))
        clock_time = format('%02d:%02d:%02d', clock.hour.value, clock.minute.value, clock.second.value)
        DrawText(clock_time, GetScreenWidth() / 2 - MeasureText(clock_time, 150) / 2, 300, 150, BLACK)
      end

      mode_name = clock_mode == CLOCK_DIGITAL ? 'DIGITAL CLOCK' : 'ANALOGUE CLOCK'
      DrawText("Press [SPACE] to switch clock mode: #{mode_name}", 10, 10, 20, DARKGRAY)
    EndDrawing()
  end

  CloseWindow()
end