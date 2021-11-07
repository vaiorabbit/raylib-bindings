# [NOTE]
# - This sample requires Ruby OpenGL bindings.
#   - https://github.com/vaiorabbit/ruby-opengl
#   - https://rubygems.org/gems/opengl-bindings
# - Ruby OpenGL bindings gem is built on top of Fiddle.
#   - https://github.com/ruby/fiddle
#   - So we need to write some interops between Fiddle and Ruby-FFI.

require 'fiddle/import'
require_relative 'util/setup_dll'
require_relative 'util/setup_opengl_dll'
require_relative 'util/resource_path'

module Sample
  extend Fiddle::Importer
  Particle = struct(["float x",
                     "float y",
                     "float period"])
end

if __FILE__ == $PROGRAM_NAME

  GLSL_VERSION = 330
  MAX_PARTICLES = 1000

  screenWidth = 800
  screenHeight = 450

  InitWindow(screenWidth, screenHeight, "Yet Another Ruby-raylib bindings - point particles")

  shader = LoadShader(TextFormat("#{RAYLIB_OTHERS_PATH}resources/shaders/glsl%i/point_particle.vs", :int, GLSL_VERSION),
                      TextFormat("#{RAYLIB_OTHERS_PATH}resources/shaders/glsl%i/point_particle.fs", :int, GLSL_VERSION))

  currentTimeLoc = GetShaderLocation(shader, "currentTime")
  colorLoc = GetShaderLocation(shader, "color")

  # Initialize the vertex buffer for the particles and assign each particle random values
  particles = Fiddle::Pointer.malloc(Sample::Particle.size * MAX_PARTICLES) # [Ruby] Allocate array of struct

  MAX_PARTICLES.times do |i|
    pt = Sample::Particle.new(particles.to_i + Sample::Particle.size * i) # [Ruby] Emplace particle
    pt.x = GetRandomValue(20, screenWidth - 20).to_f
    pt.y = GetRandomValue(50, screenWidth - 20).to_f
    # Give each particle a slightly different period. But don't spread it to much. 
    # This way the particles line up every so often and you get a glimps of what is going on.
    pt.period = GetRandomValue(10, 30) / 10.0
  end

  # that feeds the data from the buffer into the vertexPosition shader attribute.
  vao_buf, vbo_buf = ' ' * 4, ' ' * 4

  glGenVertexArrays(1, vao_buf)
  vao = vao_buf.unpack1('L')
  glBindVertexArray(vao)

  glBindVertexArray(vao)
    glGenBuffers(1, vbo_buf)
    vbo = vbo_buf.unpack1('L')
    glBindBuffer(GL_ARRAY_BUFFER, vbo)
    glBufferData(GL_ARRAY_BUFFER, MAX_PARTICLES * Sample::Particle.size, particles, GL_STATIC_DRAW)
    ## Note: LoadShader() automatically fetches the attribute index of "vertexPosition" and saves it in shader.locs[SHADER_LOC_VERTEX_POSITION]
    location_pos_ffi_ptr = shader[:locs] + (FFI::NativeType::INT32.size * SHADER_LOC_VERTEX_POSITION)
    location_pos = location_pos_ffi_ptr.read_uint
    glVertexAttribPointer(location_pos, 3, GL_FLOAT, GL_FALSE, 0, 0)
    glEnableVertexAttribArray(0)
    glBindBuffer(GL_ARRAY_BUFFER, 0)
  glBindVertexArray(0)

  # Allows the vertex shader to set the point size of each particle individually
  glEnable(GL_PROGRAM_POINT_SIZE)

  SetTargetFPS(60)

  until WindowShouldClose()
    BeginDrawing()

      ClearBackground(RAYWHITE)

      DrawRectangle(10, 10, 210, 30, MAROON)
      DrawText(TextFormat("%zu particles in one vertex buffer", :size_t, MAX_PARTICLES), 20, 20, 10, RAYWHITE)

      rlDrawRenderBatchActive() # Draw iternal buffers data (previous draw calls)

      # Switch to plain OpenGL
      glUseProgram(shader[:id])
        glUniform1f(currentTimeLoc, GetTime())

        color = ColorNormalize(Color.from_u8(255, 0, 0, 128))
        glUniform4fv(colorLoc, 1, color.pointer.read_array_of_float(4).pack('F4'))

        # Get the current modelview and projection matrix so the particle system is displayed and transformed
        modelViewProjection = MatrixMultiply(rlGetMatrixModelview(), rlGetMatrixProjection())

        location_mtx_ffi_ptr = shader[:locs] + (FFI::NativeType::INT32.size * SHADER_LOC_MATRIX_MVP)
        location_mtx = location_mtx_ffi_ptr.read_uint
        glUniformMatrix4fv(location_mtx, 1, GL_FALSE, MatrixToFloat(modelViewProjection).pack('F16'))

        glBindVertexArray(vao)
          glDrawArrays(GL_POINTS, 0, MAX_PARTICLES)
        glBindVertexArray(0)

      glUseProgram(0)

      DrawFPS(screenWidth - 100, 10)

    EndDrawing()
  end

  glDeleteBuffers(1, [vbo].pack('L*'))
  glDeleteVertexArrays(1, [vao].pack('L*'))
  UnloadShader(shader)

  Fiddle.free(particles)

  CloseWindow()
end
