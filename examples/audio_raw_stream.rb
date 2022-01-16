require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME

  MAX_SAMPLES = 512
  MAX_SAMPLES_PER_UPDATE = 4096

  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - raw audio streaming")

  InitAudioDevice()

  SetAudioStreamBufferSizeDefault(MAX_SAMPLES_PER_UPDATE)

  # Init raw audio stream (sample rate: 22050, sample size: 16bit-short, channels: 1-mono)
  stream = LoadAudioStream(44100, 16, 1)

  # Buffer for the single cycle waveform we are synthesizing
  data = FFI::MemoryPointer.new(FFI::NativeType::INT16.size * MAX_SAMPLES)

  # Frame buffer, describing the waveform when repeated over the course of a frame
  writeBuf = FFI::MemoryPointer.new(FFI::NativeType::INT16.size * MAX_SAMPLES_PER_UPDATE)

  PlayAudioStream(stream) # Start processing stream buffer (no data loaded currently)

  # Position read in to determine next frequency
  mousePosition = Vector2.create(-100.0, -100.0)

  # Cycles per second (hz)
  frequency = 440.0

  # Previous value, used to test if sine needs to be rewritten, and to smoothly modulate frequency
  oldFrequency = 1.0

  # Cursor to read and copy the samples of the sine wave buffer
  readCursor = 0

  # Computed size in samples of the sine wave
  waveLength = 1

  position = Vector2.create(0, 0)

  SetTargetFPS(30)

  until WindowShouldClose()

    mousePosition = GetMousePosition()

    if IsMouseButtonDown(MOUSE_BUTTON_LEFT)
      fp = mousePosition[:y].to_f
      frequency = 40.0 + fp

      pan = mousePosition[:x] / screenWidth.to_f
      SetAudioStreamPan(stream, pan)
    end

    # Rewrite the sine wave.
    # Compute two cycles to allow the buffer padding, simplifying any modulation, resampling, etc.
    if frequency != oldFrequency
      # Compute wavelength. Limit size in both directions.
      oldWavelength = waveLength
      waveLength = (22050 / frequency).to_i
      waveLength = MAX_SAMPLES / 2 if waveLength > MAX_SAMPLES / 2
      waveLength = 1 if waveLength < 1

      # Write sine wave.
      (waveLength * 2).times do |i|
        data.put_int16(FFI::NativeType::INT16.size * i, (Math.sin(2*Math::PI*i / waveLength) * 32000).to_i)
      end

      # Scale read cursor's position to minimize transition artifacts
      readCursor = (readCursor * (waveLength / oldWavelength.to_f)).to_i
      oldFrequency = frequency
    end

    # Refill audio stream if required
    if IsAudioStreamProcessed(stream)

      # Synthesize a buffer that is exactly the requested size
      writeCursor = 0

      while writeCursor < MAX_SAMPLES_PER_UPDATE

        # Start by trying to write the whole chunk at once
        writeLength = MAX_SAMPLES_PER_UPDATE - writeCursor

        # Limit to the maximum readable size
        readLength = waveLength - readCursor

        writeLength = readLength if writeLength > readLength

        # Write the slice
        writeBuf.put_bytes(FFI::NativeType::INT16.size * writeCursor, data.get_bytes(FFI::NativeType::INT16.size * readCursor, writeLength * FFI::NativeType::INT16.size))

        # Update cursors and loop audio
        readCursor = (readCursor + writeLength) % waveLength

        writeCursor += writeLength
      end

      # Copy finished frame to audio stream
      UpdateAudioStream(stream, writeBuf, MAX_SAMPLES_PER_UPDATE)
    end

    BeginDrawing()
      ClearBackground(RAYWHITE)
      DrawText("sine frequency: #{frequency.to_i}", GetScreenWidth() - 220, 10, 20, RED)
      DrawText("click mouse button to change frequency or pan", 10, 10, 20, DARKGRAY)

      # Draw the current buffer state proportionate to the screen
      screenWidth.times do |i|
        position[:x] = i.to_f
        position[:y] = 250 + 50 * data.get_int16(((i.to_f / screenWidth.to_f) * MAX_SAMPLES).to_i * FFI::NativeType::INT16.size) / 32000.0
        DrawPixelV(position, RED)
      end
    EndDrawing()
  end

  UnloadAudioStream(stream)
  CloseAudioDevice()
  CloseWindow()
end
