require 'raylib'
shared_lib_path = Gem::Specification.find_by_name('raylib-bindings').full_gem_path + '/lib/'

case RUBY_PLATFORM
when /mswin|msys|mingw|cygwin/
  Raylib.load_lib(shared_lib_path + 'libraylib.dll', method_naming: :snake_case, raygui_libpath: shared_lib_path + 'raygui.dll', physac_libpath: shared_lib_path + 'physac.dll')
when /darwin/
  arch = RUBY_PLATFORM.split('-')[0]
  Raylib.load_lib(shared_lib_path + "libraylib.#{arch}.dylib", method_naming: :snake_case, raygui_libpath: shared_lib_path + "raygui.#{arch}.dylib", physac_libpath: shared_lib_path + "physac.#{arch}.dylib")
when /linux/
  arch = RUBY_PLATFORM.split('-')[0]
  Raylib.load_lib(shared_lib_path + "libraylib.#{arch}.so", method_naming: :snake_case, raygui_libpath: shared_lib_path + "raygui.#{arch}.so", physac_libpath: shared_lib_path + "physac.#{arch}.so")
else
  raise RuntimeError, "Unknown OS: #{RUBY_PLATFORM}"
end

# Draw sphere without any matrix transformation
# NOTE: Sphere is drawn in world position ( 0, 0, 0 ) with radius 1.0f
def draw_sphere_basic(color)
  rings = 16
  slices = 16

  # Make sure there is enough space in the internal render batch
  # buffer to store all required vertex, batch is reseted if required
  rl_check_render_batch_limit((rings + 2)*slices*6)

  rl_begin(RL_TRIANGLES)
    rl_color_4ub(color.r, color.g, color.b, color.a)

    (rings + 2).times do |i|
      slices.times do |j|
        rl_vertex_3f(Math.cos(DEG2RAD*(270+(180/(rings + 1))*i))*Math.sin(DEG2RAD*(j*360/slices)),
                   Math.sin(DEG2RAD*(270+(180/(rings + 1))*i)),
                   Math.cos(DEG2RAD*(270+(180/(rings + 1))*i))*Math.cos(DEG2RAD*(j*360/slices)))
        rl_vertex_3f(Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.sin(DEG2RAD*((j+1)*360/slices)),
                   Math.sin(DEG2RAD*(270+(180/(rings + 1))*(i+1))),
                   Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.cos(DEG2RAD*((j+1)*360/slices)))
        rl_vertex_3f(Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.sin(DEG2RAD*(j*360/slices)),
                   Math.sin(DEG2RAD*(270+(180/(rings + 1))*(i+1))),
                   Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.cos(DEG2RAD*(j*360/slices)))

        rl_vertex_3f(Math.cos(DEG2RAD*(270+(180/(rings + 1))*i))*Math.sin(DEG2RAD*(j*360/slices)),
                   Math.sin(DEG2RAD*(270+(180/(rings + 1))*i)),
                   Math.cos(DEG2RAD*(270+(180/(rings + 1))*i))*Math.cos(DEG2RAD*(j*360/slices)))
        rl_vertex_3f(Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i)))*Math.sin(DEG2RAD*((j+1)*360/slices)),
                   Math.sin(DEG2RAD*(270+(180/(rings + 1))*(i))),
                   Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i)))*Math.cos(DEG2RAD*((j+1)*360/slices)))
        rl_vertex_3f(Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.sin(DEG2RAD*((j+1)*360/slices)),
                   Math.sin(DEG2RAD*(270+(180/(rings + 1))*(i+1))),
                   Math.cos(DEG2RAD*(270+(180/(rings + 1))*(i+1)))*Math.cos(DEG2RAD*((j+1)*360/slices)))
      end
    end
  rl_end()
end

include Raylib

if __FILE__ == $PROGRAM_NAME
  screenWidth = 800
  screenHeight = 450

  sunRadius = 4.0
  earthRadius = 0.6
  earthOrbitRadius = 8.0
  moonRadius = 0.16
  moonOrbitRadius = 1.5

  init_window(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - rlgl module usage with push/pop matrix transformations")

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

  set_target_fps(60)

  until window_should_close()
    update_camera(camera.pointer, CAMERA_FREE)

    earthRotation += (5.0*rotationSpeed)
    earthOrbitRotation += (365/360.0*(5.0*rotationSpeed)*rotationSpeed)
    moonRotation += (2.0*rotationSpeed)
    moonOrbitRotation += (8.0*rotationSpeed)

    begin_drawing()

      clear_background(RAYWHITE)

      begin_mode_3d(camera)

        rl_push_matrix()
          rl_scalef(sunRadius, sunRadius, sunRadius)         # Scale Sun
          draw_sphere_basic(GOLD)                             # Draw the Sun
        rl_pop_matrix()

        rl_push_matrix()
          rl_rotatef(earthOrbitRotation, 0.0, 1.0, 0.0)      # Rotation for Earth orbit around Sun
          rl_translatef(earthOrbitRadius, 0.0, 0.0)          # Translation for Earth orbit

          rl_push_matrix()
            rl_rotatef(earthRotation, 0.25, 1.0, 0.0)        # Rotation for Earth itself
            rl_scalef(earthRadius, earthRadius, earthRadius) # Scale Earth

            draw_sphere_basic(BLUE)                           # Draw the Earth
          rl_pop_matrix()

          rl_rotatef(moonOrbitRotation, 0.0, 1.0, 0.0)       # Rotation for Moon orbit around Earth
          rl_translatef(moonOrbitRadius, 0.0, 0.0)           # Translation for Moon orbit
          rl_rotatef(moonRotation, 0.0, 1.0, 0.0)            # Rotation for Moon itself
          rl_scalef(moonRadius, moonRadius, moonRadius)      # Scale Moon

          draw_sphere_basic(LIGHTGRAY)                        # Draw the Moon
        rl_pop_matrix()

        # Some reference elements (not affected by previous matrix transformations)
        draw_circle_3d(Vector3.create(0.0, 0.0, 0.0), earthOrbitRadius, Vector3.create(1, 0, 0), 90.0, fade(RED, 0.5))
        draw_grid(20, 1.0)

      end_mode_3d()

      draw_text("EARTH ORBITING AROUND THE SUN!", 400, 10, 20, MAROON)
      draw_fps(10, 10)

    end_drawing()
  end

  close_window()
end
