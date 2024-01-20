# Yet another raylib wrapper for Ruby
#
# * https://github.com/vaiorabbit/raylib-bindings
#
# Demonstrates several key features including:
# * Core      : window management, camera, etc.
# * Gameplay  : fetching player input, collision handling, etc.
# * Rendering : drawing shapes, texts, etc.
#
# To get more information, see:
# * https://www.raylib.com/cheatsheet/cheatsheet.html for API reference
# * https://github.com/vaiorabbit/raylib-bindings/tree/main/examples for more actual codes written in Ruby

require_relative '../lib/raylib'

shared_lib_path = '../lib/' # Gem::Specification.find_by_name('raylib-bindings').full_gem_path + '/lib/'

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

if __FILE__ == $PROGRAM_NAME
  screen_width = 1280
  screen_height = 720
  Raylib.init_window(screen_width, screen_height, "Yet Another Ruby-raylib bindings")
  Raylib.set_target_fps(60)

  ruby_red = Raylib::Color.from_u8(155, 17, 30, 255)

  # Camera
  camera = Raylib::Camera.new
  reset_camera = lambda {
    camera.position.set(0.0, 10.0, 10.0)
    camera.target.set(0.0, 0.0, 0.0)
    camera.up.set(0.0, 1.0, 0.0)
    camera.fovy = 45.0
    camera.projection = Raylib::CAMERA_PERSPECTIVE
  }
  reset_camera.call
  camera_mode = Raylib::CAMERA_CUSTOM
  auto_rotate = false

  # Player (red cube) settings
  player_pos = Raylib::Vector3.create(0.0, 0.0, 0.0)
  player_size = Raylib::Vector3.create(2.0, 2.0, 2.0)
  speed = 0.25

  # Obstacle settings
  obstacle_cube_pos = Raylib::Vector3.create(-4.0, 1.0, 0.0)
  obstacle_cube_size = Raylib::Vector3.create(2.0, 2.0, 2.0)
  obstacle_sphere_pos = Raylib::Vector3.create(4.0, 0.0, 0.0)
  obstacle_sphere_size = 1.5

  until Raylib.window_should_close()
    ### Update phase

    # Reset camera settings
    if Raylib.is_key_pressed(Raylib::KEY_F1)
      auto_rotate = !auto_rotate
      reset_camera.call
      camera_mode = auto_rotate ? Raylib::CAMERA_ORBITAL : Raylib::CAMERA_CUSTOM
    end
    Raylib.update_camera(camera.pointer, camera_mode) if auto_rotate

    # Calculate move direction
    move = Raylib::Vector3.create(0, 0, 0)
    move.x += speed if Raylib.is_key_down(Raylib::KEY_RIGHT)
    move.x -= speed if Raylib.is_key_down(Raylib::KEY_LEFT)
    move.z += speed if Raylib.is_key_down(Raylib::KEY_DOWN)
    move.z -= speed if Raylib.is_key_down(Raylib::KEY_UP)

    to_camera = Raylib.vector3_normalize(Raylib::Vector3.create(camera.position.x, 0, camera.position.z))
    rotate_y = Raylib.quaternion_from_vector3_to_vector3(Raylib::Vector3.create(0, 0, 1), to_camera)
    move = Raylib.vector3_rotate_by_quaternion(move, rotate_y)

    player_pos = Raylib.vector3_add(player_pos, move)
    player_screen_pos = Raylib.get_world_to_screen(Raylib::Vector3.create(player_pos.x, player_pos.y + 2.5, player_pos.z), camera)

    # Check collision status
    collision = false

    player_bbox = Raylib::BoundingBox.new
                    .with_min(player_pos.x - player_size.x/2, player_pos.y - player_size.y/2, player_pos.z - player_size.z/2)
                    .with_max(player_pos.x + player_size.x/2, player_pos.y + player_size.y/2, player_pos.z + player_size.z/2)

    obstacle_cube_bbox = Raylib::BoundingBox.new
                           .with_min(obstacle_cube_pos.x - obstacle_cube_size.x/2, obstacle_cube_pos.y - obstacle_cube_size.y/2, obstacle_cube_pos.z - obstacle_cube_size.z/2)
                           .with_max(obstacle_cube_pos.x + obstacle_cube_size.x/2, obstacle_cube_pos.y + obstacle_cube_size.y/2, obstacle_cube_pos.z + obstacle_cube_size.z/2)

    # Check collisions player vs obstacle_cube
    collision = true if Raylib.check_collision_boxes(player_bbox, obstacle_cube_bbox)

    # Check collisions player vs obstacle_sphere
    collision = true if Raylib.check_collision_box_sphere(player_bbox, obstacle_sphere_pos, obstacle_sphere_size)

    ### Rendering phase

    Raylib.begin_drawing()

      Raylib.clear_background(Raylib::RAYWHITE)

      ## 3D scene
      Raylib.begin_mode_3d(camera)
        # Red cube
        Raylib.draw_cube(player_pos, 2.0, 2.0, 2.0, collision ? Raylib.fade(ruby_red, 0.25) : ruby_red)
        Raylib.draw_cube_wires(player_pos, 2.0, 2.0, 2.0, Raylib::MAROON)
        # Obstacle cube
        Raylib.draw_cube(obstacle_cube_pos, obstacle_cube_size.x, obstacle_cube_size.y, obstacle_cube_size.z, Raylib::GRAY)
        Raylib.draw_cube_wires(obstacle_cube_pos, obstacle_cube_size.x, obstacle_cube_size.y, obstacle_cube_size.z, Raylib::DARKGRAY)
        # Obstacle sphere
        Raylib.draw_sphere(obstacle_sphere_pos, obstacle_sphere_size, Raylib::GRAY)
        Raylib.draw_sphere_wires(obstacle_sphere_pos, obstacle_sphere_size, 16, 16, Raylib::DARKGRAY)
        # Floor
        Raylib.draw_grid(10, 1)
      Raylib.end_mode_3d()

      ## HUD
      # Text over the red cube
      Raylib.draw_text("Player HP: 100 / 100", player_screen_pos.x - Raylib.measure_text("Player HP: 100/100", 20)/2, player_screen_pos.y, 20, Raylib::BLACK)
      # Help message
      Raylib.draw_rectangle(10, screen_height - 100, 300, 80, Raylib.fade(Raylib::MAROON, 0.25))
      Raylib.draw_rectangle_lines(10, screen_height - 100, 300, 80, ruby_red)
      Raylib.draw_text("Arrow keys : move red cube", 20, screen_height - 90, 20, Raylib::BLACK)
      Raylib.draw_text("F1 : camera rotation", 20, screen_height - 70, 20, Raylib::BLACK)
      Raylib.draw_text("ESC : exit", 20, screen_height - 50, 20, Raylib::BLACK)
      # FPS
      Raylib.draw_fps(screen_width - 100, 16)

    Raylib.end_drawing()
  end

  Raylib.close_window()
end
