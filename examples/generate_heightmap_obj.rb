require 'optparse'
require_relative 'util/setup_dll'
require_relative 'util/resource_path'

if __FILE__ == $PROGRAM_NAME
  options = {}
  OptionParser.new do |opt|
    opt.on('-i', '--image path_to_image') { |o| options[:path] = o }
    opt.on('-x', '--x_length x') { |o| options[:x] = o.to_f }
    opt.on('-z', '--z_length z') { |o| options[:z] = o.to_f }
    opt.on('-y', '--y_height y') { |o| options[:y] = o.to_f }
  end.parse!

  options[:x] = 16.0 if options[:x].nil?
  options[:z] = 16.0 if options[:z].nil?
  options[:y] = 8.0 if options[:y].nil?
  options[:path] = RAYLIB_MODELS_PATH + "resources/heightmap.png" if options[:path].nil?

  SetTraceLogLevel(LOG_ERROR)
  InitWindow(0, 0, '')

  image = LoadImage(options[:path])
  mesh = GenMeshHeightmap(image, Vector3.create(options[:x], options[:y], options[:z]))
  UnloadImage(image)

  vertices = mesh[:vertices]
  vertexCount = mesh[:vertexCount]
  triangleCount = mesh[:triangleCount]
  raise RuntimeError unless vertexCount == triangleCount * 3

  vertexCount.times do |i|
    vtxs = vertices.get_array_of_float32(FFI::NativeType::FLOAT32.size * 3 * i, 3)
    puts "v #{vtxs[0]} #{vtxs[1]} #{vtxs[2]}"
  end
  triangleCount.times do |i|
    puts "f #{3 * i + 1} #{3 * i + 2} #{3 * i + 3}"
  end

  UnloadMesh(mesh)
  CloseWindow()
end
