require_relative 'util/setup_dll'

$dataLoaded = false
$dataLoadedLock = Mutex.new
$dataProgress = 0
$dataProgressLock = Mutex.new

if __FILE__ == $PROGRAM_NAME
  InitWindow(800, 450, "Yet Another Ruby-raylib bindings - loading thread")

  STATE_WAITING = 0
  STATE_LOADING = 1
  STATE_FINISHED = 2
  state = STATE_WAITING

  framesCounter = 0

  SetTargetFPS(60)
  until WindowShouldClose()

    # Update

    case state
    when STATE_WAITING
      if IsKeyPressed(KEY_ENTER)
        begin
          th = Thread.new do
            timeCounter = 0
            prevTime = Process.clock_gettime(Process::CLOCK_MONOTONIC)

            while timeCounter < 5.0
              currentTime = Process.clock_gettime(Process::CLOCK_MONOTONIC) - prevTime
              timeCounter = currentTime
              $dataProgressLock.synchronize do
                $dataProgress = timeCounter * 100
              end
            end

            $dataLoadedLock.synchronize do
              $dataLoaded = true
            end
          end
        rescue
          TraceLog(LOG_ERROR, "Error creating loading thread")
          exit
        end

        TraceLog(LOG_INFO, "Loading thread initialized successfully")
        state = STATE_LOADING
      end

    when STATE_LOADING
      framesCounter += 1
      $dataLoadedLock.synchronize do
        if $dataLoaded
          framesCounter = 0
          state = STATE_FINISHED
        end
      end

    when STATE_FINISHED
      if (IsKeyPressed(KEY_ENTER))
        # Reset everything to launch again
        $dataLoadedLock.synchronize do
          $dataLoaded = false
        end
        dataProgress = 0
        state = STATE_WAITING
      end

    end

    # Draw

    BeginDrawing()
      ClearBackground(RAYWHITE)

      case state
      when STATE_WAITING
        DrawText("PRESS ENTER to START LOADING DATA", 150, 170, 20, DARKGRAY)

      when STATE_LOADING
        $dataProgressLock.synchronize do
          DrawRectangle(150, 200, $dataProgress, 60, SKYBLUE)
        end
        DrawText("LOADING DATA...", 240, 210, 40, DARKBLUE) if (framesCounter / 15) % 2 != 0

      when STATE_FINISHED
        DrawRectangle(150, 200, 500, 60, LIME)
        DrawText("DATA LOADED!", 250, 210, 40, GREEN)

      end

      DrawRectangleLines(150, 200, 500, 60, DARKGRAY)
    EndDrawing()
  end

  CloseWindow()
end
