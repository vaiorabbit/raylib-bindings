# [Usage]
# $ gem install raylib-bindings
# $ gem install imgui-bindings
# $ ruby examples/raylib_with_imgui.rb

require 'raylib'

def imgui_bindings_gem_available?
  Gem::Specification.find_by_name('imgui-bindings')
rescue Gem::LoadError
  false
rescue
  Gem.available?('imgui-bindings')
end

if imgui_bindings_gem_available?
  require 'imgui'
  require 'imgui_impl_docking_raylib'
else
  require_relative '../lib/imgui'
  require_relative '../lib/imgui_impl_docking_raylib'
end

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

  if imgui_bindings_gem_available?
    imgui_spec = Gem::Specification.find_by_name('imgui-bindings')
    shared_lib_path = imgui_spec.full_gem_path + '/lib/'
    ImGui.load_lib("#{shared_lib_path}imgui.#{shared_lib_suffix}")
  else
    local_lib_path = File.expand_path('../lib', __dir__) + '/'
    ImGui.load_lib("#{local_lib_path}imgui.#{shared_lib_suffix}")
  end

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

  ImGui.ImplDockingRaylib_Init()

  io = ImGuiIO.new(ImGui.GetIO())
  fonts = ImFontAtlas.new(io[:Fonts])
  fonts.AddFontDefault()

  # - docking: enabled
  # - multi-viewports: unsupported by raylib backend (auto-disabled in backend)
  io[:ConfigFlags] |= ImGuiConfigFlags_DockingEnable
  io[:ConfigFlags] |= ImGuiConfigFlags_ViewportsEnable

  cube_color = Raylib::GREEN

  Raylib.SetTargetFPS(60)

  until Raylib.WindowShouldClose()
    ImGui.ImplDockingRaylib_NewFrame()
    ImGui.NewFrame()

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

    # ImGui-aware camera update: skips mouse/keyboard camera controls
    # while ImGui is actively capturing those inputs.
    ImGui.ImplRaylib_UpdateCamera(camera, Raylib::CAMERA_FIRST_PERSON)

    Raylib.BeginDrawing()
      Raylib.ClearBackground(Raylib::RAYWHITE)

      Raylib.DrawFPS(screen_width - 100, 10)
      Raylib.BeginMode3D(camera)
      Raylib.DrawCube(Raylib::Vector3.create(0, 0, 0), 1.0, 1.0, 1.0, cube_color)
      Raylib.DrawCubeWires(Raylib::Vector3.create(0, 0, 0), 1.0, 1.0, 1.0, Raylib::BLUE)
      Raylib.DrawGrid(10, 1)
      Raylib.EndMode3D()

      ImGui.Begin('Raylib Backend Check')
      ImGui.Text('Backend target: Docking ON, Multi-Viewport OFF')
      ImGui.Separator()
      ImGui.Text("DockingEnable: #{(io[:ConfigFlags] & ImGuiConfigFlags_DockingEnable) != 0}")
      ImGui.Text('ViewportsEnable request: true')
      ImGui.Text("ViewportsEnable effective: #{(io[:ConfigFlags] & ImGuiConfigFlags_ViewportsEnable) != 0}")
      ImGui.Separator()
      ImGui.Text('Cube turns red when clicking outside ImGui window.')
      ImGui.End()

      ImGui.ShowDemoWindow()

      ImGui.Render()
      ImGui.ImplDockingRaylib_RenderDrawData(ImGui.GetDrawData())
    Raylib.EndDrawing()
  end

  ImGui.ImplDockingRaylib_Shutdown()
  ImGui.DestroyContext(nil)
  Raylib.CloseWindow()
end
