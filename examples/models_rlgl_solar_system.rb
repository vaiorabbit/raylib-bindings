require_relative 'util/setup_dll'

# Draw sphere without any matrix transformation
# NOTE: Sphere is drawn in world position ( 0, 0, 0 ) with radius 1.0f
def DrawSphereBasic(color)
  rings = 16
  slices = 16

  # Make sure there is enough space in the internal render batch
  # buffer to store all required vertex, batch is reseted if required
  rlCheckRenderBatchLimit((rings + 2)*slices*6)

  rlBegin(RL_TRIANGLES)
    rlColor4ub(color.r, color.g, color.b, color.a)

    (rings + 2).times do |i|
      slices.times do |j|
        rlVertex3f(Math.cos(DEG2RAD*(270+(180/(rings + 1))*i))*Math.sin(DEG2RAD*(j*360/slices)),
                   Math.sin(DEG2RAD*(270+(180/(rings + 1))*i)),
                   Math.cos(DEG2RAD*(270+(180/(rings + 1))*i))*Math.cos(DEG2RAD*(j*360/slices)))
        rlVertex3f(Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.sin(DEG2RAD*((j+1)*360/slices)),
                   Math.sin(DEG2RAD*(270+(180/(rings + 1))*(i+1))),
                   Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.cos(DEG2RAD*((j+1)*360/slices)))
        rlVertex3f(Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.sin(DEG2RAD*(j*360/slices)),
                   Math.sin(DEG2RAD*(270+(180/(rings + 1))*(i+1))),
                   Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.cos(DEG2RAD*(j*360/slices)))

        rlVertex3f(Math.cos(DEG2RAD*(270+(180/(rings + 1))*i))*Math.sin(DEG2RAD*(j*360/slices)),
                   Math.sin(DEG2RAD*(270+(180/(rings + 1))*i)),
                   Math.cos(DEG2RAD*(270+(180/(rings + 1))*i))*Math.cos(DEG2RAD*(j*360/slices)))
        rlVertex3f(Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i)))*Math.sin(DEG2RAD*((j+1)*360/slices)),
                   Math.sin(DEG2RAD*(270+(180/(rings + 1))*(i))),
                   Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i)))*Math.cos(DEG2RAD*((j+1)*360/slices)))
        rlVertex3f(Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.sin(DEG2RAD*((j+1)*360/slices)),
                   Math.sin(DEG2RAD*(270+(180/(rings + 1))*(i+1))),
                   Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.cos(DEG2RAD*((j+1)*360/slices)))
      end
    end
  rlEnd()
end

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  sunRadius = 4.0
  earthRadius = 0.6
  earthOrbitRadius = 8.0
  moonRadius = 0.16
  moonOrbitRadius = 1.5

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - rlgl module usage with push/pop matrix transformations")

  # Define the camera to look into our 3d world
  camera = Camera.new
             .with_position(16.0, 16.0, 16.0)
             .with_target(0.0, 0.0, 0.0)
             .with_up(0.0, 1.0, 0.0)
             .with_fovy(45.0)
             .with_projection(CAMERA_PERSPECTIVE)

  rotationSpeed = 0.2         # General system rotation speed

  earthRotation = 0.0         # Rotation of earth around itself (days) in degrees
  earthOrbitRotation = 0.0    # Rotation of earth around the Sun (years) in degrees
  moonRotation = 0.0          # Rotation of moon around itself
  moonOrbitRotation = 0.0     # Rotation of moon around earth in degrees

  SetTargetFPS(60)

  until WindowShouldClose()
    UpdateCamera(camera.pointer, CAMERA_FREE)

    earthRotation += (5.0*rotationSpeed)
    earthOrbitRotation += (365/360.0*(5.0*rotationSpeed)*rotationSpeed)
    moonRotation += (2.0*rotationSpeed)
    moonOrbitRotation += (8.0*rotationSpeed)

    BeginDrawing()

      ClearBackground(RAYWHITE)

      BeginMode3D(camera)

        rlPushMatrix()
          rlScalef(sunRadius, sunRadius, sunRadius)         # Scale Sun
          DrawSphereBasic(GOLD)                             # Draw the Sun
        rlPopMatrix()

        rlPushMatrix()
          rlRotatef(earthOrbitRotation, 0.0, 1.0, 0.0)      # Rotation for Earth orbit around Sun
          rlTranslatef(earthOrbitRadius, 0.0, 0.0)          # Translation for Earth orbit

          rlPushMatrix()
            rlRotatef(earthRotation, 0.25, 1.0, 0.0)        # Rotation for Earth itself
            rlScalef(earthRadius, earthRadius, earthRadius) # Scale Earth

            DrawSphereBasic(BLUE)                           # Draw the Earth
          rlPopMatrix()

          rlRotatef(moonOrbitRotation, 0.0, 1.0, 0.0)       # Rotation for Moon orbit around Earth
          rlTranslatef(moonOrbitRadius, 0.0, 0.0)           # Translation for Moon orbit
          rlRotatef(moonRotation, 0.0, 1.0, 0.0)            # Rotation for Moon itself
          rlScalef(moonRadius, moonRadius, moonRadius)      # Scale Moon

          DrawSphereBasic(LIGHTGRAY)                        # Draw the Moon
        rlPopMatrix()

        # Some reference elements (not affected by previous matrix transformations)
        DrawCircle3D(Vector3.create(0.0, 0.0, 0.0), earthOrbitRadius, Vector3.create(1, 0, 0), 90.0, Fade(RED, 0.5))
        DrawGrid(20, 1.0)

      EndMode3D()

      DrawText("EARTH ORBITING AROUND THE SUN!", 400, 10, 20, MAROON)
      DrawFPS(10, 10)

    EndDrawing()
  end

  CloseWindow()
end
