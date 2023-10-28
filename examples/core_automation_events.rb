require_relative 'util/setup_dll'

class Player
  attr_accessor :position, :speed, :canJump

  def initialize()
    @position = Vector2.create(400, 280)
    @speed = 0.0
    @canJump = false
  end
end

class EnvElement
  attr_accessor :rect, :blocking, :color

  def initialize(rect, blocking, color)
    @rect = rect
    @blocking = blocking
    @color = color
  end
end

if __FILE__ == $PROGRAM_NAME
  GRAVITY = 400
  PLAYER_JUMP_SPD = 350.0
  PLAYER_HOR_SPD = 200.0
  MAX_ENVIRONMENT_ELEMENTS = 5
  MAX_BUILDINGS = 100

  screenWidth = 800
  screenHeight = 450
  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - automation events")

  player = Player.new

  envElements = [
    EnvElement.new(Rectangle.create(0, 0, 1000, 400), 0, LIGHTGRAY),
    EnvElement.new(Rectangle.create(0, 400, 1000, 200), 1, GRAY),
    EnvElement.new(Rectangle.create(300, 200, 400, 10), 1, GRAY),
    EnvElement.new(Rectangle.create(250, 300, 100, 10), 1, GRAY),
    EnvElement.new(Rectangle.create(650, 300, 100, 10), 1, GRAY),
  ]

  camera = Camera2D.new
             .with_target(player.position.x, player.position.y)
             .with_offset(screenWidth / 2.0, screenHeight / 2.0)
             .with_rotation(0.0)
             .with_zoom(1.0)

  aelist = LoadAutomationEventList(nil)
  SetAutomationEventList(aelist.pointer)

  eventRecording = false
  eventPlaying = false

  frameCounter = 0
  playFrameCounter = 0
  currentPlayFrame = 0

  SetTargetFPS(60)

  reset_state = lambda {
    player.position.set(400, 280)
    player.speed = 0
    player.canJump = false

    camera.target.set(player.position.x, player.position.y)
    camera.offset.x = screenWidth/2.0
    camera.offset.y = screenHeight/2.0
    camera.rotation = 0.0
    camera.zoom = 1.0
  }

  until WindowShouldClose()

    deltaTime = 0.015 # GetFrameTime()

    if IsFileDropped()
      droppedFiles = LoadDroppedFiles()
      file_path = droppedFiles.paths.get_array_of_string(0, droppedFiles.count)
      if IsFileExtension(file_path[0], ".txt;.rae")
        UnloadAutomationEventList(aelist.pointer)
        aelist = LoadAutomationEventList(file_path[0])

        eventRecording = false

        # Reset scene state to play
        eventPlaying = true
        playFrameCounter = 0
        currentPlayFrame = 0

        reset_state.call
      end
      UnloadDroppedFiles(droppedFiles)
    end

    # Update player
    player.position.x -= PLAYER_HOR_SPD * deltaTime if IsKeyDown(KEY_LEFT)
    player.position.x += PLAYER_HOR_SPD * deltaTime if IsKeyDown(KEY_RIGHT)
    if IsKeyDown(KEY_SPACE) && player.canJump
      player.speed = -PLAYER_JUMP_SPD
      player.canJump = false
    end

    hitObstacle = false
    envElements.each do |element|
      if element.blocking &&
         (element.rect.x <= player.position.x) && (element.rect.x + element.rect.width >= player.position.x) &&
         (element.rect.y >= player.position.y) && (element.rect.y <= player.position.y + player.speed * deltaTime)
        hitObstacle = true
        player.speed = 0.0
        player.position.y = element.rect.y
      end
    end

    unless hitObstacle
      player.position.y += player.speed * deltaTime
      player.speed += GRAVITY * deltaTime
      player.canJump = false
    else
      player.canJump = true
    end

    camera.zoom += GetMouseWheelMove() * 0.05
    camera.zoom = camera.zoom.clamp(0.25, 3.0)

    reset_state.call if IsKeyPressed(KEY_R)

    # Camera target follows player
    camera.target.set(player.position.x, player.position.y)
    camera.offset.x = screenWidth/2.0
    camera.offset.y = screenHeight/2.0

    minX = 1000
    minY = 1000
    maxX = -1000
    maxY = -1000
    envElements.each do |element|
      minX = [element.rect.x, minX].min
      maxX = [element.rect.x + element.rect.width, maxX].max
      minY = [element.rect.y, minY].min
      maxY = [element.rect.y + element.rect.height, maxY].max
    end

    max = GetWorldToScreen2D(Vector2.create(maxX, maxY), camera)
    min = GetWorldToScreen2D(Vector2.create(minX, minY), camera)

    camera.offset.x = screenWidth - (max.x - screenWidth/2) if max.x < screenWidth
    camera.offset.y = screenHeight - (max.y - screenHeight/2) if max.y < screenHeight
    camera.offset.x = screenWidth/2 - min.x if min.x > 0
    camera.offset.y = screenHeight/2 - min.y if min.y > 0

    # Toggle events recording
    if IsKeyPressed(KEY_F2)
      unless eventPlaying
        if eventRecording
          StopAutomationEventRecording()
          eventRecording = false
          ExportAutomationEventList(aelist, "automation.rae")
        else
          SetAutomationEventBaseFrame(180)
          StartAutomationEventRecording()
          eventRecording = true
        end
      end
    elsif IsKeyPressed(KEY_F3)
      if !eventRecording && (aelist.count > 0)
        # Reset scene state to play
        eventPlaying = true
        playFrameCounter = 0
        currentPlayFrame = 0
        reset_state.call
      end
    end

    if eventPlaying
      # NOTE: Multiple events could be executed in a single frame
      aelist_event = AutomationEvent.new(aelist.events + currentPlayFrame * AutomationEvent.size)
      while playFrameCounter == aelist_event.frame
        PlayAutomationEvent(aelist_event)
        currentPlayFrame += 1
        if currentPlayFrame == aelist.count
          eventPlaying = false
          currentPlayFrame = 0
          playFrameCounter = 0
        end
        aelist_event = AutomationEvent.new(aelist.events + currentPlayFrame * AutomationEvent.size)
      end
      playFrameCounter += 1
    end

    if (eventRecording || eventPlaying)
      frameCounter += 1
    else
      frameCounter = 0
    end

    BeginDrawing()
      ClearBackground(LIGHTGRAY)

      BeginMode2D(camera)
        envElements.each do |element|
          DrawRectangleRec(element.rect, element.color)
        end
        DrawRectangleRec(Rectangle.create(player.position.x - 20, player.position.y - 40, 40, 40), RED)
      EndMode2D()

      DrawRectangle(10, 10, 290, 145, Fade(SKYBLUE, 0.5))
      DrawRectangleLines(10, 10, 290, 145, Fade(BLUE, 0.8))

      # Draw game controls
      DrawText("Controls:", 20, 20, 10, BLACK)
      DrawText("- RIGHT | LEFT: Player movement", 30, 40, 10, DARKGRAY)
      DrawText("- SPACE: Player jump", 30, 60, 10, DARKGRAY)
      DrawText("- R: Reset game state", 30, 80, 10, DARKGRAY)

      DrawText("- F2: START/STOP RECORDING INPUT EVENTS", 30, 110, 10, BLACK)
      DrawText("- F3: REPLAY LAST RECORDED INPUT EVENTS", 30, 130, 10, BLACK)

      # Draw automation events recording indicator
      if eventRecording
        DrawRectangle(10, 160, 290, 30, Fade(RED, 0.3))
        DrawRectangleLines(10, 160, 290, 30, Fade(MAROON, 0.8))
        DrawCircle(30, 175, 10, MAROON)
        DrawText(TextFormat("RECORDING EVENTS... [%i]", :int, aelist.count), 50, 170, 10, MAROON) if (((frameCounter/15)%2) == 1)
      elsif (eventPlaying)
        DrawRectangle(10, 160, 290, 30, Fade(LIME, 0.3))
        DrawRectangleLines(10, 160, 290, 30, Fade(DARKGREEN, 0.8))
        DrawTriangle(Vector2.create(20, 155 + 10), Vector2.create(20, 155 + 30), Vector2.create(40, 155 + 20), DARKGREEN)
        DrawText(TextFormat("PLAYING RECORDED EVENTS... [%i]", :int, currentPlayFrame), 50, 170, 10, DARKGREEN) if (((frameCounter/15)%2) == 1)
      end

    EndDrawing()
  end

  CloseWindow()
end
