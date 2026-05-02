require_relative 'util/setup_dll'

STAGE_HALF_LENGTH = 5.0
DOT_EPSILON = 1.0e-6

def draw_cone(width, height, length, color)
  rlPushMatrix()

  rlBegin(RL_LINES)
  rlColor4ub(color.r, color.g, color.b, color.a)

  # Bottom
  rlVertex3f(-width / 2.0, -height / 2.0, -length / 2.0)
  rlVertex3f(+width / 2.0, -height / 2.0, -length / 2.0)

  rlVertex3f(+width / 2.0, -height / 2.0, -length / 2.0)
  rlVertex3f(+width / 2.0, +height / 2.0, -length / 2.0)

  rlVertex3f(+width / 2.0, +height / 2.0, -length / 2.0)
  rlVertex3f(-width / 2.0, +height / 2.0, -length / 2.0)

  rlVertex3f(-width / 2.0, +height / 2.0, -length / 2.0)
  rlVertex3f(-width / 2.0, -height / 2.0, -length / 2.0)

  # Apex
  rlVertex3f(-width / 2.0, -height / 2.0, -length / 2.0)
  rlVertex3f(width / 2.0, height / 2.0, +length / 2.0)

  rlVertex3f(+width / 2.0, -height / 2.0, -length / 2.0)
  rlVertex3f(width / 2.0, height / 2.0, +length / 2.0)

  rlVertex3f(+width / 2.0, +height / 2.0, -length / 2.0)
  rlVertex3f(width / 2.0, height / 2.0, +length / 2.0)

  rlVertex3f(-width / 2.0, +height / 2.0, -length / 2.0)
  rlVertex3f(width / 2.0, height / 2.0, +length / 2.0)

  rlEnd()
  rlPopMatrix()
end

def normalize_or_zero(v)
  len_sq = Vector3LengthSqr(v)
  return Vector3Zero() if len_sq <= DOT_EPSILON

  Vector3Scale(v, 1.0 / Math.sqrt(len_sq))
end

class Params
  attr_accessor :min_speed, :max_speed, :foward_fov_degree, :near_radius,
                :wall_x_min, :wall_x_max, :wall_y_min, :wall_y_max, :wall_z_min, :wall_z_max,
                :wall_near_threshold, :wall_repulsion_scale,
                :separation_scale, :alignment_force_scale, :cohesion_force_scale

  def initialize
    @min_speed = 1.5
    @max_speed = 10.0
    @foward_fov_degree = 60.0
    @near_radius = 1.0
    @wall_x_min = -STAGE_HALF_LENGTH
    @wall_x_max = STAGE_HALF_LENGTH
    @wall_y_min = -STAGE_HALF_LENGTH
    @wall_y_max = STAGE_HALF_LENGTH
    @wall_z_min = -STAGE_HALF_LENGTH
    @wall_z_max = STAGE_HALF_LENGTH
    @wall_near_threshold = 1.0
    @wall_repulsion_scale = 5.0
    @separation_scale = 10.0
    @alignment_force_scale = 15.0
    @cohesion_force_scale = 2.0
  end
end

class Boid
  attr_accessor :flock, :pos, :vel, :acc, :rot, :neighbors, :params

  def initialize(params = Params.new)
    @flock = nil
    @pos = Vector3.create(0.0, 0.0, 0.0)
    @vel = Vector3.create(0.0, 0.0, 0.0)
    @acc = Vector3.create(0.0, 0.0, 0.0)
    @rot = MatrixIdentity()
    @neighbors = []
    @params = params
  end

  def update(dt)
    update_neighbor
    update_walls
    update_separation
    update_alignment
    update_cohesion
    update_move(dt)
  end

  def update_move(dt)
    @vel = Vector3Add(@vel, Vector3Scale(@acc, dt))
    @vel = Vector3ClampValue(@vel, @params.min_speed, @params.max_speed)
    @pos = Vector3Add(@pos, Vector3Scale(@vel, dt))

    dir = normalize_or_zero(@vel)
    q = QuaternionFromVector3ToVector3(Vector3.create(0.0, 0.0, 1.0), dir)
    @rot = QuaternionToMatrix(q)

    @acc = Vector3Zero()
  end

  def update_neighbor
    @neighbors.clear
    dot_product_threshold = Math.cos(@params.foward_fov_degree * DEG2RAD)
    near_radius_sq = @params.near_radius * @params.near_radius
    forward = normalize_or_zero(@vel)

    @flock.boids.each do |other|
      next if equal?(other)

      to_other = Vector3Subtract(other.pos, @pos)
      to_distance_sq = Vector3LengthSqr(to_other)
      next if to_distance_sq > near_radius_sq

      dir = normalize_or_zero(to_other)
      @neighbors << other if Vector3DotProduct(forward, dir) > dot_product_threshold
    end
  end

  def update_walls
    distance = @params.wall_x_max - @pos.x
    if distance <= @params.wall_near_threshold
      distance = [distance, DOT_EPSILON].max
      @acc.x += -1.0 * @params.wall_repulsion_scale * (1.0 / (distance * distance))
    end

    distance = @pos.x - @params.wall_x_min
    if distance <= @params.wall_near_threshold
      distance = [distance, DOT_EPSILON].max
      @acc.x += +1.0 * @params.wall_repulsion_scale * (1.0 / (distance * distance))
    end

    distance = @params.wall_y_max - @pos.y
    if distance <= @params.wall_near_threshold
      distance = [distance, DOT_EPSILON].max
      @acc.y += -1.0 * @params.wall_repulsion_scale * (1.0 / (distance * distance))
    end

    distance = @pos.y - @params.wall_y_min
    if distance <= @params.wall_near_threshold
      distance = [distance, DOT_EPSILON].max
      @acc.y += +1.0 * @params.wall_repulsion_scale * (1.0 / (distance * distance))
    end

    distance = @params.wall_z_max - @pos.z
    if distance <= @params.wall_near_threshold
      distance = [distance, DOT_EPSILON].max
      @acc.z += -1.0 * @params.wall_repulsion_scale * (1.0 / (distance * distance))
    end

    distance = @pos.z - @params.wall_z_min
    if distance <= @params.wall_near_threshold
      distance = [distance, DOT_EPSILON].max
      @acc.z += +1.0 * @params.wall_repulsion_scale * (1.0 / (distance * distance))
    end
  end

  def update_separation
    return if @neighbors.empty?

    scale = 1.0 / @neighbors.size
    separation_force = Vector3Zero()

    @neighbors.each do |neighbor|
      away = Vector3Subtract(@pos, neighbor.pos)
      separation_force = Vector3Add(separation_force, Vector3Scale(normalize_or_zero(away), scale))
    end

    @acc = Vector3Add(@acc, Vector3Scale(separation_force, @params.separation_scale))
  end

  def update_alignment
    return if @neighbors.empty?

    scale = 1.0 / @neighbors.size
    avg_vel = Vector3Zero()

    @neighbors.each do |neighbor|
      avg_vel = Vector3Add(avg_vel, Vector3Scale(neighbor.vel, scale))
    end

    alignment_force = Vector3Scale(Vector3Subtract(avg_vel, @vel), @params.alignment_force_scale)
    @acc = Vector3Add(@acc, alignment_force)
  end

  def update_cohesion
    return if @neighbors.empty?

    scale = 1.0 / @neighbors.size
    avg_pos = Vector3Zero()

    @neighbors.each do |neighbor|
      avg_pos = Vector3Add(avg_pos, Vector3Scale(neighbor.pos, scale))
    end

    cohesion_force = Vector3Scale(Vector3Subtract(avg_pos, @pos), @params.cohesion_force_scale)
    @acc = Vector3Add(@acc, cohesion_force)
  end
end

class Flock
  attr_accessor :boids, :params

  def initialize
    @boids = []
    @params = Params.new
  end

  def add_boid(boid)
    @boids << boid
  end

  def update(dt)
    @boids.each { |boid| boid.update(dt) }
  end

  def draw
    @boids.each do |boid|
      rlPushMatrix()
      rlTranslatef(boid.pos.x, boid.pos.y, boid.pos.z)
      rlMultMatrixf(MatrixToFloat(boid.rot).pack('F16'))
      rlScalef(0.1, 0.1, 0.5)
      draw_cone(1.0, 1.0, 1.0, ORANGE)
      rlPopMatrix()
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  screen_width = 800 * 2
  screen_height = 450 * 2

  InitWindow(screen_width, screen_height, 'raylib example - Boids simulation (Ruby)')

  camera = Camera.new
           .with_position(10.0, 4.0, 10.0)
           .with_target(0.0, 0.0, 0.0)
           .with_up(0.0, 1.0, 0.0)
           .with_fovy(45.0)
           .with_projection(CAMERA_PERSPECTIVE)

  SetTargetFPS(60)

  flock = Flock.new

  boid_count = 500
  max_rand = 32_767.0

  boid_count.times do
    boid = Boid.new(flock.params)
    dx = flock.params.wall_x_max - flock.params.wall_x_min
    dy = flock.params.wall_y_max - flock.params.wall_y_min
    dz = flock.params.wall_z_max - flock.params.wall_z_min

    boid.pos = Vector3.create(
      (GetRandomValue(-32_767, 32_767).to_f / max_rand) * 0.5 * dx,
      (GetRandomValue(-32_767, 32_767).to_f / max_rand) * 0.5 * dy,
      (GetRandomValue(-32_767, 32_767).to_f / max_rand) * 0.5 * dz
    )
    boid.vel = Vector3.create(
      (GetRandomValue(-32_767, 32_767).to_f / max_rand) * 5.0 - 2.5,
      (GetRandomValue(-32_767, 32_767).to_f / max_rand) * 5.0 - 2.5,
      (GetRandomValue(-32_767, 32_767).to_f / max_rand) * 5.0 - 2.5
    )
    boid.acc = Vector3Zero()
    boid.flock = flock
    flock.add_boid(boid)
  end

  run = false

  flock.update(GetFrameTime())

  until WindowShouldClose()
    UpdateCamera(camera.pointer, run ? CAMERA_ORBITAL : CAMERA_THIRD_PERSON)

    flock.update(GetFrameTime()) if run
    run = !run if IsKeyPressed(KEY_SPACE)

    BeginDrawing()

    ClearBackground(DARKBLUE)
    BeginMode3D(camera)
    DrawCubeWires(
      Vector3.create(0.0, 0.0, 0.0),
      flock.params.wall_x_max - flock.params.wall_x_min,
      flock.params.wall_y_max - flock.params.wall_y_min,
      flock.params.wall_z_max - flock.params.wall_z_min,
      GREEN
    )
    DrawGrid(10, 1.0)
    flock.draw
    EndMode3D()
    DrawFPS(10, 10)

    EndDrawing()
  end

  CloseWindow()
end
