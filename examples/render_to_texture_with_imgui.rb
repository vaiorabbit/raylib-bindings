# [Usage]
# $ gem install raylib-bindings
# $ gem install imgui-bindings
# $ ruby test_raylib.rb

require 'raylib'
require 'imgui'
require 'imgui_impl_raylib'

if __FILE__ == $PROGRAM_NAME
  shared_lib_suffix = case RUBY_PLATFORM
                      when /mswin|msys|mingw/
                        'dll'
                      when /darwin/
                        arch = RUBY_PLATFORM.split('-')[0]
                        "#{arch}.dylib"
                      when /linux/
                        arch = RUBY_PLATFORM.split('-')[0]
                        "#{arch}.so"
                      else
                        raise RuntimeError, "Unknown OS: #{RUBY_PLATFORM}"
                      end

  raylib_spec = Gem::Specification.find_by_name('raylib-bindings')
  shared_lib_path = raylib_spec.full_gem_path + '/lib/'
  Raylib.load_lib("#{shared_lib_path}libraylib.#{shared_lib_suffix}")

  imgui_spec = Gem::Specification.find_by_name('imgui-bindings')
  shared_lib_path = imgui_spec.full_gem_path + '/lib/'
  ImGui.load_lib("#{shared_lib_path}imgui.#{shared_lib_suffix}")

  screen_width = 1280
  screen_height = 720

  Raylib.InitWindow(screen_width, screen_height, "Ruby raylib+ImGui")

  camera = Raylib::Camera.new
             .with_position(2.5, 10.0, 10.0)
             .with_target(2.5, 0.0, 0.0)
             .with_up(0.0, 1.0, 0.0)
             .with_fovy(45.0)
             .with_projection(Raylib::CAMERA_PERSPECTIVE)

  ImGui.CreateContext()
  ImGui.StyleColorsDark()

  ImGui.ImplRaylib_Init()

  io = ImGuiIO.new(ImGui.GetIO())
  io[:Fonts].AddFontDefault()

  # Build texture atlas
  pixels = FFI::MemoryPointer.new :pointer
  width = FFI::MemoryPointer.new :int
  height = FFI::MemoryPointer.new :int
  io[:Fonts].GetTexDataAsRGBA32(pixels, width, height, nil)

  # Upload texture to graphics system
  # [TODO] find standard and safe way to convert RGBA32 array into texture
  image = Raylib.GenImageColor(width.read_int, height.read_int, Raylib::BLUE)
  original_data = image[:data]
  image[:data] = pixels.read_pointer

  texture = Raylib.LoadTextureFromImage(image)
  image[:data] = original_data
  Raylib.UnloadImage(image)

  # Store our identifier
  # texture_ptr = FFI::MemoryPointer.new(:uint32)
  # texture_ptr.write(:uint32, texture[:id])
  # io[:Fonts].SetTexID(texture_ptr)
  io[:Fonts].SetTexID(texture[:id])

  render_target = Raylib.LoadRenderTexture(screen_width / 1.5, screen_height / 1.5)

  cube_color = Raylib::GREEN

  Raylib.SetTargetFPS(60)

  until Raylib.WindowShouldClose()
    # Check io[:WantCaptureMouse] to detect the timing when ImGui exclusively requires Mosue/Keyboard information
    cube_color = if not io[:WantCaptureMouse]
                   # Change cube color to Raylib::RED when user clicked outside of ImGui window
                   if Raylib.IsMouseButtonDown(Raylib::MOUSE_BUTTON_LEFT)
                     Raylib::RED
                   else
                     Raylib::GREEN
                   end
                 else
                   Raylib::GREEN
                 end

    # [NOTE] We can't use UpdateCamera because Keyboard API (IsKeyDown, etc.) and
    #        Mouse API (GetMouseWheelMove, etc.) are used inside without checking io[:WantCaptureMouse].
    # Raylib.UpdateCamera(camera.pointer, Raylib::CAMERA_ORBITAL)

    Raylib.BeginTextureMode(render_target)
      Raylib.ClearBackground(Raylib::RAYWHITE)

      Raylib.DrawFPS(screen_width - 100, 10)
      Raylib.BeginMode3D(camera)
      Raylib.DrawCube(Raylib::Vector3.create(0, 0, 0), 1.0, 1.0, 1.0, cube_color)
      Raylib.DrawCubeWires(Raylib::Vector3.create(0, 0, 0), 1.0, 1.0, 1.0, Raylib::BLUE)
      Raylib.DrawGrid(10, 1)
      Raylib.EndMode3D()
    Raylib.EndTextureMode()

    Raylib.BeginDrawing()
      Raylib.ClearBackground(Raylib::BEIGE)
      Raylib.DrawTextureRec(render_target.texture, Raylib::Rectangle.create(0, 0, render_target.texture.width.to_f, -render_target.texture.height.to_f), Raylib::Vector2.create(0, 0), Raylib::WHITE)

      ImGui.ImplRaylib_NewFrame()
      ImGui.NewFrame()
      ImGui.ShowDemoWindow()
      sz = ImVec2.create(render_target.texture.width / 2, render_target.texture.height / 2)
      ImGui.SetNextWindowPos(ImVec2.create(200, 400), ImGuiCond_Once)
      ImGui.SetNextWindowSize(sz, ImGuiCond_Once)
      ImGui.Begin('Render Target Texture')
        # Flip y coordinate (See https://github.com/ocornut/imgui/wiki/Image-Loading-and-Displaying-Examples )
        uv0 = ImVec2.create(0.0, 1.0)
        uv1 = ImVec2.create(1.0, 0.0)
        ImGui.Image(render_target[:texture][:id], sz, uv0, uv1)
      ImGui.End()
      ImGui.Render()
      ImGui.ImplRaylib_RenderDrawData(ImGui.GetDrawData())
    Raylib.EndDrawing()
  end

  ImGui.ImplRaylib_Shutdown()
  ImGui.DestroyContext(nil)
  Raylib.CloseWindow()
end
