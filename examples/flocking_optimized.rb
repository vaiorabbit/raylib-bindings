require_relative 'util/setup_dll'

STAGE_HALF_LENGTH = 5.0
DOT_EPSILON = 1.0e-6

module RaymathRuby
  module_function

  Vec3 = Struct.new(:x, :y, :z)
  Quat = Struct.new(:x, :y, :z, :w)
  Mat4 = Struct.new(
    :m0, :m4, :m8, :m12,
    :m1, :m5, :m9, :m13,
    :m2, :m6, :m10, :m14,
    :m3, :m7, :m11, :m15
  ) do
    def pack_f16
      [m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15].pack('F16')
    end
  end

  def vector3_create(x = 0.0, y = 0.0, z = 0.0)
    Vec3.new(x, y, z)
  end

  def vector3_zero
    vector3_create(0.0, 0.0, 0.0)
  end

  def quaternion_from_vector3_to_vector3(from, to)
    # Ported from raymath.h: QuaternionFromVector3ToVector3()
    cos2_theta = (from.x * to.x) + (from.y * to.y) + (from.z * to.z)
    cross_x = (from.y * to.z) - (from.z * to.y)
    cross_y = (from.z * to.x) - (from.x * to.z)
    cross_z = (from.x * to.y) - (from.y * to.x)

    quat = Quat.new(
      cross_x,
      cross_y,
      cross_z,
      Math.sqrt((cross_x * cross_x) + (cross_y * cross_y) + (cross_z * cross_z) + (cos2_theta * cos2_theta)) + cos2_theta
    )

    length = Math.sqrt((quat.x * quat.x) + (quat.y * quat.y) + (quat.z * quat.z) + (quat.w * quat.w))
    length = 1.0 if length.zero?
    inv_length = 1.0 / length

    Quat.new(
      quat.x * inv_length,
      quat.y * inv_length,
      quat.z * inv_length,
      quat.w * inv_length
    )
  end

  def matrix_identity
    Mat4.new(
      1.0, 0.0, 0.0, 0.0,
      0.0, 1.0, 0.0, 0.0,
      0.0, 0.0, 1.0, 0.0,
      0.0, 0.0, 0.0, 1.0
    )
  end

  def quaternion_to_matrix(q)
    # Ported from raymath.h: QuaternionToMatrix()
    result = matrix_identity

    a2 = q.x * q.x
    b2 = q.y * q.y
    c2 = q.z * q.z
    ac = q.x * q.z
    ab = q.x * q.y
    bc = q.y * q.z
    ad = q.w * q.x
    bd = q.w * q.y
    cd = q.w * q.z

    result.m0 = 1.0 - (2.0 * (b2 + c2))
    result.m1 = 2.0 * (ab + cd)
    result.m2 = 2.0 * (ac - bd)

    result.m4 = 2.0 * (ab - cd)
    result.m5 = 1.0 - (2.0 * (a2 + c2))
    result.m6 = 2.0 * (bc + ad)

    result.m8 = 2.0 * (ac + bd)
    result.m9 = 2.0 * (bc - ad)
    result.m10 = 1.0 - (2.0 * (a2 + b2))

    result
  end

  def to_rl_vector3(v)
    Vector3.create(v.x, v.y, v.z)
  end
end

FORWARD_VECTOR = RaymathRuby.vector3_create(0.0, 0.0, 1.0)

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

# Uniform-grid spatial index.
# Cell side length equals near_radius so all potential neighbors of a boid
# are guaranteed to reside in the immediately surrounding 3×3×3 block of cells.
class SpatialGrid
  def initialize(x_min, x_max, y_min, y_max, z_min, z_max, cell_size)
    @cell_size     = cell_size.to_f
    @inv_cell_size = 1.0 / @cell_size
    @x_min = x_min.to_f
    @y_min = y_min.to_f
    @z_min = z_min.to_f
    @nx = ((x_max - x_min) * @inv_cell_size).ceil + 1
    @ny = ((y_max - y_min) * @inv_cell_size).ceil + 1
    @nz = ((z_max - z_min) * @inv_cell_size).ceil + 1
    @stride_y = @nx
    @stride_z = @nx * @ny
    @cells = Array.new(@nx * @ny * @nz) { [] }
  end

  def clear
    @cells.each(&:clear)
  end

  def insert(idx, x, y, z)
    cx = ((x - @x_min) * @inv_cell_size).floor.clamp(0, @nx - 1)
    cy = ((y - @y_min) * @inv_cell_size).floor.clamp(0, @ny - 1)
    cz = ((z - @z_min) * @inv_cell_size).floor.clamp(0, @nz - 1)
    @cells[cx + cy * @stride_y + cz * @stride_z] << idx
  end

  # Yields indices of all boids in the 3×3×3 neighborhood around (x, y, z).
  def each_candidate(x, y, z)
    cx = ((x - @x_min) * @inv_cell_size).floor
    cy = ((y - @y_min) * @inv_cell_size).floor
    cz = ((z - @z_min) * @inv_cell_size).floor
    x0 = [cx - 1, 0].max;     x1 = [cx + 1, @nx - 1].min
    y0 = [cy - 1, 0].max;     y1 = [cy + 1, @ny - 1].min
    z0 = [cz - 1, 0].max;     z1 = [cz + 1, @nz - 1].min
    iz = z0
    while iz <= z1
      iy = y0
      while iy <= y1
        ix = x0
        while ix <= x1
          @cells[ix + iy * @stride_y + iz * @stride_z].each { |idx| yield idx }
          ix += 1
        end
        iy += 1
      end
      iz += 1
    end
  end
end

class Params
  attr_accessor :min_speed, :max_speed, :foward_fov_degree, :near_radius,
                :wall_x_min, :wall_x_max, :wall_y_min, :wall_y_max, :wall_z_min, :wall_z_max,
                :wall_near_threshold, :wall_repulsion_scale,
                :separation_scale, :alignment_force_scale, :cohesion_force_scale

  attr_reader :dot_product_threshold, :near_radius_sq

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

    @dot_product_threshold = Math.cos(@foward_fov_degree * DEG2RAD)
    @near_radius_sq = @near_radius * @near_radius
  end
end

class Boid
  attr_accessor :flock, :pos, :vel, :acc, :rot, :params

  def initialize(params = Params.new)
    @flock = nil
    @pos = RaymathRuby.vector3_create(0.0, 0.0, 0.0)
    @vel = RaymathRuby.vector3_create(0.0, 0.0, 0.0)
    @acc = RaymathRuby.vector3_create(0.0, 0.0, 0.0)
    @rot = RaymathRuby.matrix_identity
    @params = params
  end

  def update(dt)
    update_walls
    update_move(dt)
  end

  def update_move(dt)
    vx = @vel.x + (@acc.x * dt)
    vy = @vel.y + (@acc.y * dt)
    vz = @vel.z + (@acc.z * dt)

    speed_sq = (vx * vx) + (vy * vy) + (vz * vz)
    if speed_sq > DOT_EPSILON
      speed = Math.sqrt(speed_sq)
      if speed < @params.min_speed
        scale = @params.min_speed / speed
        vx *= scale
        vy *= scale
        vz *= scale
      elsif speed > @params.max_speed
        scale = @params.max_speed / speed
        vx *= scale
        vy *= scale
        vz *= scale
      end
    end

    @vel.x = vx
    @vel.y = vy
    @vel.z = vz
    @pos.x += vx * dt
    @pos.y += vy * dt
    @pos.z += vz * dt

    if speed_sq > DOT_EPSILON
      inv_speed = 1.0 / Math.sqrt(speed_sq)
      dir = RaymathRuby.vector3_create(vx * inv_speed, vy * inv_speed, vz * inv_speed)
      q = RaymathRuby.quaternion_from_vector3_to_vector3(FORWARD_VECTOR, dir)
      @rot = RaymathRuby.quaternion_to_matrix(q)
    end

    @acc.x = 0.0
    @acc.y = 0.0
    @acc.z = 0.0
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
end

class Flock
  attr_accessor :boids, :params

  def initialize
    @boids  = []
    @params = Params.new
    @grid   = nil
    # Flat arrays for batch neighbor computation (allocated lazily)
    @px = []; @py = []; @pz = []
    @vx = []; @vy = []; @vz = []
    @fwd_x = []; @fwd_y = []; @fwd_z = []
    @sep_x = []; @sep_y = []; @sep_z = []
    @ali_x = []; @ali_y = []; @ali_z = []
    @coh_x = []; @coh_y = []; @coh_z = []
    @nc = []
  end

  def add_boid(boid)
    @boids << boid
  end

  def update(dt)
    update_all_behaviors
    @boids.each { |boid| boid.update(dt) }
  end

  def draw
    @boids.each do |boid|
      rlPushMatrix()
      rlTranslatef(boid.pos.x, boid.pos.y, boid.pos.z)
      rlMultMatrixf(boid.rot.pack_f16)
      rlScalef(0.1, 0.1, 0.5)
      draw_cone(1.0, 1.0, 1.0, ORANGE)
      rlPopMatrix()
    end
  end

  private

  def ensure_grid
    @grid ||= SpatialGrid.new(
      @params.wall_x_min, @params.wall_x_max,
      @params.wall_y_min, @params.wall_y_max,
      @params.wall_z_min, @params.wall_z_max,
      @params.near_radius
    )
  end

  def ensure_arrays(n)
    return if @px.size == n
    @px = Array.new(n, 0.0); @py = Array.new(n, 0.0); @pz = Array.new(n, 0.0)
    @vx = Array.new(n, 0.0); @vy = Array.new(n, 0.0); @vz = Array.new(n, 0.0)
    @fwd_x = Array.new(n, 0.0); @fwd_y = Array.new(n, 0.0); @fwd_z = Array.new(n, 0.0)
    @sep_x = Array.new(n, 0.0); @sep_y = Array.new(n, 0.0); @sep_z = Array.new(n, 0.0)
    @ali_x = Array.new(n, 0.0); @ali_y = Array.new(n, 0.0); @ali_z = Array.new(n, 0.0)
    @coh_x = Array.new(n, 0.0); @coh_y = Array.new(n, 0.0); @coh_z = Array.new(n, 0.0)
    @nc = Array.new(n, 0)
  end

  # Computes flocking forces for all boids in one pass.
  #
  # Optimizations applied:
  #   1. Uniform spatial grid  – reduces the neighbor search from O(n²) to O(n)
  #      by limiting each boid to the 3×3×3 block of grid cells around it.
  #   2. Pair sharing          – each (i, j) pair is processed exactly once
  #      (when i < j).  Forces for *both* boids are accumulated in the same
  #      pass, halving the number of sqrt / dot-product calls.
  #   3. Flat position/velocity arrays – avoids repeated Struct-field dispatch
  #      in the hot inner loop; data for boid i sits at index i in each array.
  def update_all_behaviors
    n = @boids.size
    ensure_arrays(n)

    near_radius_sq = @params.near_radius_sq
    dot_threshold  = @params.dot_product_threshold
    sep_scale      = @params.separation_scale
    ali_scale      = @params.alignment_force_scale
    coh_scale      = @params.cohesion_force_scale

    # ── Step 1: snapshot boid state into flat arrays ───────────────────────
    n.times do |i|
      b  = @boids[i]
      px = b.pos.x; py = b.pos.y; pz = b.pos.z
      vx = b.vel.x; vy = b.vel.y; vz = b.vel.z
      @px[i] = px; @py[i] = py; @pz[i] = pz
      @vx[i] = vx; @vy[i] = vy; @vz[i] = vz

      speed_sq = vx * vx + vy * vy + vz * vz
      if speed_sq > DOT_EPSILON
        inv_s = 1.0 / Math.sqrt(speed_sq)
        @fwd_x[i] = vx * inv_s; @fwd_y[i] = vy * inv_s; @fwd_z[i] = vz * inv_s
      else
        @fwd_x[i] = 0.0; @fwd_y[i] = 0.0; @fwd_z[i] = 0.0
      end

      @sep_x[i] = 0.0; @sep_y[i] = 0.0; @sep_z[i] = 0.0
      @ali_x[i] = 0.0; @ali_y[i] = 0.0; @ali_z[i] = 0.0
      @coh_x[i] = 0.0; @coh_y[i] = 0.0; @coh_z[i] = 0.0
      @nc[i] = 0
    end

    # ── Step 2: populate spatial grid ──────────────────────────────────────
    grid = ensure_grid
    grid.clear
    n.times { |i| grid.insert(i, @px[i], @py[i], @pz[i]) }

    # ── Step 3: accumulate pairwise forces (each pair processed once) ──────
    n.times do |i|
      pxi = @px[i]; pyi = @py[i]; pzi = @pz[i]
      fxi = @fwd_x[i]; fyi = @fwd_y[i]; fzi = @fwd_z[i]
      vxi = @vx[i];    vyi = @vy[i];    vzi = @vz[i]

      grid.each_candidate(pxi, pyi, pzi) do |j|
        next if j <= i  # each pair (i, j) with i < j is processed once

        dx = @px[j] - pxi
        dy = @py[j] - pyi
        dz = @pz[j] - pzi
        distance_sq = dx * dx + dy * dy + dz * dz
        next if distance_sq > near_radius_sq

        if distance_sq > DOT_EPSILON
          inv_dist = 1.0 / Math.sqrt(distance_sq)

          # Does i see j? (i's forward FOV check)
          if (fxi * dx + fyi * dy + fzi * dz) * inv_dist > dot_threshold
            @sep_x[i] -= dx * inv_dist; @sep_y[i] -= dy * inv_dist; @sep_z[i] -= dz * inv_dist
            @ali_x[i] += @vx[j]; @ali_y[i] += @vy[j]; @ali_z[i] += @vz[j]
            @coh_x[i] += @px[j]; @coh_y[i] += @py[j]; @coh_z[i] += @pz[j]
            @nc[i] += 1
          end

          # Does j see i? (j's forward FOV check; direction from j→i is -dx,-dy,-dz)
          fxj = @fwd_x[j]; fyj = @fwd_y[j]; fzj = @fwd_z[j]
          if (-fxj * dx - fyj * dy - fzj * dz) * inv_dist > dot_threshold
            @sep_x[j] += dx * inv_dist; @sep_y[j] += dy * inv_dist; @sep_z[j] += dz * inv_dist
            @ali_x[j] += vxi; @ali_y[j] += vyi; @ali_z[j] += vzi
            @coh_x[j] += pxi; @coh_y[j] += pyi; @coh_z[j] += pzi
            @nc[j] += 1
          end
        else
          # Boids at nearly identical positions: always neighbors, skip FOV / separation
          @ali_x[i] += @vx[j]; @ali_y[i] += @vy[j]; @ali_z[i] += @vz[j]
          @coh_x[i] += @px[j]; @coh_y[i] += @py[j]; @coh_z[i] += @pz[j]
          @nc[i] += 1
          @ali_x[j] += vxi; @ali_y[j] += vyi; @ali_z[j] += vzi
          @coh_x[j] += pxi; @coh_y[j] += pyi; @coh_z[j] += pzi
          @nc[j] += 1
        end
      end
    end

    # ── Step 4: write accumulated forces into boid.acc ─────────────────────
    n.times do |i|
      next if @nc[i].zero?

      b     = @boids[i]
      scale = 1.0 / @nc[i]
      vxi   = @vx[i]; vyi = @vy[i]; vzi = @vz[i]
      pxi   = @px[i]; pyi = @py[i]; pzi = @pz[i]

      b.acc.x += (@sep_x[i] * scale) * sep_scale
      b.acc.y += (@sep_y[i] * scale) * sep_scale
      b.acc.z += (@sep_z[i] * scale) * sep_scale

      b.acc.x += ((@ali_x[i] * scale) - vxi) * ali_scale
      b.acc.y += ((@ali_y[i] * scale) - vyi) * ali_scale
      b.acc.z += ((@ali_z[i] * scale) - vzi) * ali_scale

      b.acc.x += ((@coh_x[i] * scale) - pxi) * coh_scale
      b.acc.y += ((@coh_y[i] * scale) - pyi) * coh_scale
      b.acc.z += ((@coh_z[i] * scale) - pzi) * coh_scale
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

    boid.pos = RaymathRuby.vector3_create(
      (GetRandomValue(-32_767, 32_767).to_f / max_rand) * 0.5 * dx,
      (GetRandomValue(-32_767, 32_767).to_f / max_rand) * 0.5 * dy,
      (GetRandomValue(-32_767, 32_767).to_f / max_rand) * 0.5 * dz
    )
    boid.vel = RaymathRuby.vector3_create(
      (GetRandomValue(-32_767, 32_767).to_f / max_rand) * 5.0 - 2.5,
      (GetRandomValue(-32_767, 32_767).to_f / max_rand) * 5.0 - 2.5,
      (GetRandomValue(-32_767, 32_767).to_f / max_rand) * 5.0 - 2.5
    )
    boid.acc = RaymathRuby.vector3_zero
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
      RaymathRuby.to_rl_vector3(RaymathRuby.vector3_create(0.0, 0.0, 0.0)),
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
