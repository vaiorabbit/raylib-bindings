class Game
  attr_reader :high_score, :config, :current_score, :state_timer

  STATES = [:Ready, :Playing, :GameOver]

  StageConfig = Struct.new(:screen_width, :screen_height)

  STATE_READY_DURATION = 0.25
  STATE_GAMEOVER_DURATION = 1.0

  def initialize
    @config = StageConfig.new(480, 720)
    @high_score = 0
    reset
  end

  def reset(keep_high_score: true)
    @state = :Ready
    @current_score = 0
    @high_score = 0 unless :keep_high_score
    @state_timer = 0.0
  end

  def update(dt)
    @state_timer += dt
    case @state
    when :Ready
      if @state_timer > STATE_READY_DURATION && (Raylib.IsKeyDown(Raylib::KEY_SPACE) || Raylib.IsMouseButtonDown(Raylib::MOUSE_BUTTON_LEFT))
        @state_timer = 0.0
        @state = :Playing
      end
    end
  end

  def set_state(new_state)
    raise ArgumentError unless STATES.include? new_state
    @state = new_state
    @state_timer = 0.0
  end
  private :set_state

  def finish = set_state(:GameOver)

  def ready? = @state == :Ready

  def game_over? = @state == :GameOver

  def current_score=(new_score)
    @current_score = new_score
    @high_score = @current_score if @current_score > @high_score
  end
end

class Dot
  attr_accessor :pos
  attr_reader :radius, :large

  SCORE_NORMAL = 10
  SCORE_LARGE = 50

  FONT_SIZE_NORMAL = 12
  FONT_SIZE_LARGE = 14

  RADIUS_NORMAL = 8.0
  RADIUS_LARGE = 24.0

  def initialize(pos_x, pos_y, large_on:)
    @pos = Raylib::Vector2.new(pos_x, pos_y)
    @size = Raylib::Vector2.new
    reset(large_on:)
  end

  def reset(large_on: false)
    @large = large_on
    @radius = large_on ? RADIUS_LARGE : RADIUS_NORMAL
    @size.x = @radius; @size.y = @radius
    @active = true
  end

  def hit?(offset, circle_center, circle_radius)
    hit = Raylib.CheckCollisionCircles(Raylib::Vector2.new(@pos.x + offset, @pos.y), @radius, circle_center, circle_radius)
    return hit, hit ? score() : 0
  end

  def eaten? = !@active

  def hide = @active = false

  def score = @large ? SCORE_LARGE : SCORE_NORMAL

  def render(offset_x)
    orange = Raylib::Color.new(255, 161, 0, 255)
    if @large
      Raylib.DrawCircle(offset_x + @pos.x + @radius * 0.5 - RADIUS_NORMAL, @pos.y - @radius * 0.25 + RADIUS_NORMAL, @radius, orange)
    else
      Raylib.DrawRectangle(offset_x + @pos.x, @pos.y, @size.x, @size.y, orange)
    end
  end

  def render_score(offset_x)
    red = Raylib::Color.new(230, 41, 55, 255)
    if @large
      Raylib.DrawText(SCORE_LARGE.to_s, offset_x + @pos.x, @pos.y, FONT_SIZE_LARGE, red)
    else
      Raylib.DrawText(SCORE_NORMAL.to_s, offset_x + @pos.x, @pos.y, FONT_SIZE_NORMAL, red)
    end
  end
end

class Obstacle
  attr_reader :width, :top, :bottom, :pos_x
  def initialize(width, top, bottom, stage_height, pos_x)
    stage_height = 0.0 if stage_height < 0.0
    top = 0.0 if top < 0.0
    bottom = stage_height if bottom > stage_height
    bottom = top if bottom < top

    @width = width
    @top = top
    @bottom = bottom
    @stage_height = stage_height
    @pos_x = pos_x
  end

  def gap_center_y = (@top + @bottom) * 0.5

  def hit?(offset, circle_center, circle_radius)
    check_height = 1000000.0
    rect_top = Raylib::Rectangle.new(offset + 0.0, -check_height, @width, check_height + @top)
    return true if Raylib.CheckCollisionCircleRec(circle_center, circle_radius, rect_top)

    rect_bottom = Raylib::Rectangle.new(offset + 0.0, @bottom, @width, @stage_height - @bottom)
    return true if Raylib.CheckCollisionCircleRec(circle_center, circle_radius, rect_bottom)

    return false
  end

  def render(offset)
    blue = Raylib::Color.new(0, 121, 241, 255)
    black = Raylib::Color.new(0, 0, 0, 255)
    Raylib.DrawRectangle(offset + @pos_x + 0.0, 0.0, @width, @top, blue)
    Raylib.DrawRectangle(offset + @pos_x + 2.0, 0.0, @width - 2.0 * 2.0, @top - 2.0, black)
    Raylib.DrawRectangleLinesEx(Raylib::Rectangle.new(offset + @pos_x + 6.0, -2.0, @width - 2.0 * 6.0, @top - 4.0), 2.0, blue)

    Raylib.DrawRectangle(offset + @pos_x + 0.0, @bottom, @width, @stage_height - @bottom + 1.0, blue)
    Raylib.DrawRectangle(offset + @pos_x + 2.0, @bottom + 2.0, @width - 2.0 * 2.0, @stage_height - @bottom, black)
    Raylib.DrawRectangleLinesEx(Raylib::Rectangle.new(offset + @pos_x + 6.0, @bottom + 6.0, @width - 2.0 * 6.0, @stage_height - @bottom - 8.0), 2.0, blue)
  end
end

class Area
  attr_reader :stage_width

  SCORE_BONUS = 200
  FONT_SIZE_BONUS = 18

  def initialize(stage_width, stage_height, ground_height, obstacle_width, obstacle_interval, gap_height)
    @stage_width = stage_width
    @stage_height = stage_height
    @ground_height = ground_height
    @obstacle_width = obstacle_width
    @obstacle_interval = obstacle_interval
    @gap_height = gap_height

    @obstacles = []
    @dots = []

    @eaten_all_dots = false
  end

  def clear
    @obstacles.clear
    @dots.clear
  end

  def make_obstacles
    obstacle_min_height = 5.0
    top_min = obstacle_min_height
    top_max = @stage_height - @ground_height - @gap_height - obstacle_min_height
    obstacles_conut = (@stage_width / (@obstacle_width + @obstacle_interval)).to_i
    current_pos_x = 0.0
    obstacles_conut.times do |i|
      top = rand() * (@stage_height - @gap_height)
      top = top_min if top < top_min
      top = top_max if top > top_max
      bottom = top + @gap_height
      @obstacles << Obstacle.new(@obstacle_width, top, bottom, @stage_height - @ground_height, current_pos_x)
      current_pos_x += (@obstacle_width + @obstacle_interval)
    end
  end
  private :make_obstacles

  def make_dots
    @obstacles.each do |obstacle|
      @dots << Dot.new(obstacle.pos_x + obstacle.width * 0.5, obstacle.gap_center_y, large_on: true)
    end

    obstacles_conut = (@stage_width / (@obstacle_width + @obstacle_interval)).to_i
    current_pos_x = @obstacle_width + @obstacle_interval * 1.0
    current_pos_y = Dot::RADIUS_LARGE + Dot::RADIUS_NORMAL

    @dots << Dot.new(current_pos_x, current_pos_y, large_on: true)

    y_interval = Dot::RADIUS_NORMAL * 4.0
    current_pos_y += Dot::RADIUS_LARGE + y_interval
    16.times do |i|
      @dots << Dot.new(current_pos_x, current_pos_y, large_on: false)
      current_pos_y += y_interval
    end

    current_pos_y += Dot::RADIUS_LARGE
    @dots << Dot.new(current_pos_x, current_pos_y, large_on: true)
  end
  private :make_dots

  def eaten_dots_count
    @dots.count {|dot| dot.eaten? }
  end
  private :eaten_dots_count

  def left_dots_count
    @dots.length - eaten_dots_count()
  end
  private :eaten_dots_count

  def make
    @obstacles.clear
    make_obstacles()

    @dots.clear
    make_dots()
  end

  def hit?(offset, circle_center, circle_radius)
    score_total = 0

    left_dots_count_before = left_dots_count()
    @dots.each do |dot|
      unless dot.eaten?
        hit, score = dot.hit?(offset, circle_center, circle_radius)
        if hit
          score_total += score
          dot.hide
        end
      end
    end
    left_dots_count_after = left_dots_count()

    if left_dots_count_before > 0 && left_dots_count_after == 0
      @eaten_all_dots = true
      score_total += SCORE_BONUS
    end

    @obstacles.each do |obstacle|
      hit = obstacle.hit?(offset, circle_center, circle_radius)
      return hit, score_total if hit
    end

    return false, score_total
  end

  def render(offset)
    @obstacles.each do |obstacle|
      obstacle.render(offset)
    end

    @dots.each do |dot|
      unless dot.eaten?
        dot.render(offset)
      else
        dot.render_score(offset)
      end
    end

    if @eaten_all_dots && !@dots.empty?
      red = Raylib::Color.new(230, 41, 55, 255)
      Raylib.DrawText('Perfect!', offset + @dots.last.pos.x + 30.0, @stage_height * 0.5, FONT_SIZE_BONUS, red)
      Raylib.DrawText(SCORE_BONUS.to_s, offset + @dots.last.pos.x + 30.0, @stage_height * 0.5 + FONT_SIZE_BONUS, FONT_SIZE_BONUS, red)
    end
  end
end

class Stage
  attr_reader :width, :height, :center

  def initialize(width, height)
    @width = width
    @height = height
    @center = Raylib::Vector2.new(@width * 0.5, @height * 0.5)

    @color_bg0 = Raylib::Color.new(10, 20, 120, 255)
    @color_bg1 = Raylib::Color.new(235, 250, 220, 255)
    @color_border = Raylib::Color.new(80, 60, 170, 255)
    @color_lawn0 = Raylib::Color.new(50, 90, 230, 255)
    @color_lawn1 = Raylib::Color.new(10, 50, 200, 255)
    @color_dirt = Raylib::Color.new(215, 215, 215, 255)
    @color_building00 = Raylib::Color.new(200, 225, 225, 255)
    @color_building10 = Raylib::Color.new(160, 170, 210, 255)
    @color_building11 = Raylib::Color.new(180, 190, 230, 255)

    @building_scroll_speed = 1.0
    @building_pattern_offset = 0.0
    @building_pattern_width = 130
    @ground_height = 60.0
    @lawn_height = 20.0
    @border_height = 2.0

    @lawn_scroll_speed = 2.0
    @lawn_pattern_offset = 0.0
    @lawn_pattern_width = @lawn_height

    @areas_scroll_speed = 2.0
    @areas_pattern_offset = 0.0
    @areas_pattern_width = @width

    @obstacle_width = 150.0
    @obstacle_interval = 150.0
    @gap_height = 300.0

    @areas = [
      Area.new(@width, @height, @ground_height, @obstacle_width, @obstacle_interval, @gap_height),
      Area.new(@width, @height, @ground_height, @obstacle_width, @obstacle_interval, @gap_height),
    ]

    @building_pattern = lambda {|offset_x|
      # Layer0
      Raylib.DrawRectangle(offset_x +  5.0,       560.0,       25.0,             @height, @color_building00)
      Raylib.DrawRectangle(offset_x + 35.0,       580.0,       25.0,             @height, @color_building00)
      Raylib.DrawRectangle(offset_x + 85.0,       600.0,       25.0,             @height, @color_building00)
      Raylib.DrawRectangle(offset_x + 115.0,      590.0,       25.0,             @height, @color_building00)

      # Layer1-1
      Raylib.DrawRectangle(offset_x + 20.0,       600.0,       20.0,             @height, @color_building10)
      Raylib.DrawRectangle(offset_x + 20.0 + 2.0, 600.0 + 2.0, 20.0 - 2.0 * 2.0, @height, @color_building11)

      Raylib.DrawRectangle(offset_x + 65.0,       570.0,       30.0,             @height, @color_building10)
      Raylib.DrawRectangle(offset_x + 65.0 + 2.0, 570.0 + 2.0, 30.0 - 2.0 * 2.0, @height, @color_building11)

      # Layer1-2
      Raylib.DrawRectangle(offset_x + 50.0,       550.0,       30.0,             @height, @color_building10)
      Raylib.DrawRectangle(offset_x + 50.0 + 2.0, 550.0 + 2.0, 30.0 - 2.0 * 2.0, @height, @color_building11)

      Raylib.DrawRectangle(offset_x + 100.0,       580.0,       30.0,             @height, @color_building10)
      Raylib.DrawRectangle(offset_x + 100.0 + 2.0, 580.0 + 2.0, 30.0 - 2.0 * 2.0, @height, @color_building11)

      # Layer1-3
      Raylib.DrawRectangle(offset_x + 35.0,       620.0,       20.0,             @height, @color_building10)
      Raylib.DrawRectangle(offset_x + 35.0 + 2.0, 620.0 + 2.0, 20.0 - 2.0 * 2.0, @height, @color_building11)

      Raylib.DrawRectangle(offset_x + 75.0,       610.0,       30.0,             @height, @color_building10)
      Raylib.DrawRectangle(offset_x + 75.0 + 2.0, 610.0 + 2.0, 30.0 - 2.0 * 2.0, @height, @color_building11)
    }

    @lawn_pattern = lambda {|offset_x, base_y|
      len = @lawn_pattern_width
      repeat = 1 + (@width / (2 * len)).to_i
      repeat.times do |i|
        Raylib.DrawRectangle(offset_x + i * len * 2, base_y, len, len, @color_lawn1)
      end
    }

    reset()
  end

  def background_color = @color_bg0

  def reset
    @building_pattern_offset = 0.0
    @lawn_pattern_offset = 0.0
    @areas_pattern_offset = 0.0
    @areas[0].clear
    @areas[1].make
  end

  def update(dt)
    @building_pattern_offset -= @building_scroll_speed
    @building_pattern_offset = 0.0 if @building_pattern_offset.abs >= @building_pattern_width

    @lawn_pattern_offset -= @lawn_scroll_speed
    @lawn_pattern_offset = 0.0 if @lawn_pattern_offset.abs >= (2 * @lawn_pattern_width)

    @areas_pattern_offset -= @areas_scroll_speed
    if @areas_pattern_offset.abs >= @areas_pattern_width
      @areas_pattern_offset = 0.0
      @areas[0] = @areas[1]
      @areas[1] = Area.new(@width, @height, @ground_height, @obstacle_width, @obstacle_interval, @gap_height)
      @areas[1].make
    end
  end

  def ground_hit?(circle_center, circle_radius)
    base_y = @height - @ground_height
    rect_ground = Raylib::Rectangle.new(0.0, base_y, @width, @ground_height)
    if Raylib.CheckCollisionCircleRec(circle_center, circle_radius, rect_ground)
      return true
    end

    return false
  end
  private :ground_hit?

  def hit?(circle_center, circle_radius)
    hit_any = false
    score_total = 0
    @areas.length.times do |i|
      offset = @areas_pattern_offset + i * @areas[i].stage_width
      hit, score = @areas[i].hit?(offset, circle_center, circle_radius)
      hit_any = true if hit
      score_total += score
    end

    unless hit_any
      hit_any = ground_hit?(circle_center, circle_radius)
    end

    return hit_any, score_total
  end

  def render
    # Sky
    Raylib.DrawRectangleGradientV(0.0, 0.0, @width, @height, @color_bg0, @color_bg1)

    # Background
    5.times do |i|
      @building_pattern.call(@building_pattern_offset + i * @building_pattern_width)
    end

    # Ground
    base_y = @height - @ground_height
    Raylib.DrawRectangle(0.0, base_y,                  @width, @ground_height, @color_dirt)
    Raylib.DrawRectangle(0.0, base_y,                  @width, @border_height, @color_border)
    Raylib.DrawRectangle(0.0, base_y + @border_height, @width, @lawn_height, @color_lawn0)
    @lawn_pattern.call(@lawn_pattern_offset, base_y + @border_height)

    @areas.length.times do |i|
      offset = @areas_pattern_offset + i * @areas[i].stage_width
      @areas[i].render(offset)
    end
  end
end

class Player
  attr_reader :hit_radius
  attr_accessor :pos

  STATES = [:Alive, :Failed]

  DRAW_RADIUS = 50.0
  HIT_RADIUS = 40.0
  GRAVITY = 9.8 * 6
  VEL_BOOST = 9.8 * 1.5
  ANGLE_OFFSET_LIMIT = 45.0

  def initialize
    @pos = Raylib::Vector2.new
    reset
  end

  def reset
    @pos.x = 0.0; @pos.y = 0.0
    @draw_radius = DRAW_RADIUS
    @hit_radius = HIT_RADIUS
    @anim_mouse_timer = 0.0
    @anim_mouse_open = true
    @anim_failed_timer = 0.0
    @anim_failed_scale = 1.0
    @state = :Alive
    @vel_y = 0
    @angle_offset = 0
  end

  def set_state(new_state)
    raise ArgumentError unless STATES.include? new_state
    @state = new_state
  end
  private :set_state

  def finish = set_state(:Failed)

  def failed? = @state == :Failed

  def update(dt)
    fly = (Raylib.IsKeyPressed(Raylib::KEY_SPACE) || Raylib.IsMouseButtonPressed(Raylib::MOUSE_BUTTON_LEFT) || (Raylib.GetGestureDetected() == Raylib::GESTURE_TAP))
    if !failed? && fly
      @vel_y = -VEL_BOOST
    end
    if @state == :Alive
      @vel_y = @vel_y + GRAVITY * dt
      @pos.y = @pos.y + @vel_y
    end

    vel_clamped = @vel_y
    vel_clamped = -VEL_BOOST if vel_clamped < -VEL_BOOST
    vel_clamped = VEL_BOOST if vel_clamped > VEL_BOOST
    angle_rot_rate = vel_clamped / VEL_BOOST
    @angle_offset = ANGLE_OFFSET_LIMIT * angle_rot_rate

    case @state
    when :Alive
      @anim_mouse_open = @anim_mouse_timer <= ((1.0 / 60.0) * 4)
      @anim_mouse_timer += dt
      @anim_mouse_timer = 0.0 if @anim_mouse_timer >= ((1.0 / 60.0) * 8)
    when :Failed
      @anim_failed_scale = 1.0 - @anim_failed_timer
      @anim_failed_scale = 0.0 if @anim_failed_scale < 0.0
      @anim_failed_timer += dt
    end
  end

  def render
    radius = @draw_radius
    radius *= @anim_failed_scale if failed?
    yellow = Raylib::Color.new(253, 249, 0, 255)
    body_color = failed? ? Raylib.Fade(yellow, @anim_failed_scale) : yellow
    if @anim_mouse_open
      Raylib.DrawCircleSector(@pos, radius, 30 + @angle_offset, 330 + @angle_offset, 36, body_color)
    else
      Raylib.DrawCircle(@pos.x, @pos.y, radius, body_color)
    end
  end
end

game = Game.new
screen_width, screen_height = game.config.screen_width, game.config.screen_height

# Start raylib
# Raylib.SetTraceLogLevel(Raylib::LOG_ERROR)
Raylib.InitWindow(screen_width, screen_height, 'Yet Another Ruby-raylib bindings : flapper')
Raylib.SetTargetFPS(60)

# Initialize objects
stage = Stage.new(screen_width, screen_height)
player = Player.new

reset_game = lambda {
  game.reset
  stage.reset
  player.reset
  player.pos.x = stage.center.x; player.pos.y = screen_height * 0.5
}
reset_game.call

until Raylib.WindowShouldClose()
  # Press R (or Space/Click when game is finished) to restart
  reset_requested = Raylib.IsKeyPressed(Raylib::KEY_R) || (game.game_over? && (game.state_timer > Game::STATE_GAMEOVER_DURATION) && (Raylib.IsKeyPressed(Raylib::KEY_SPACE) || Raylib.IsMouseButtonPressed(Raylib::MOUSE_BUTTON_LEFT)))
  reset_game.call if reset_requested

  dt = Raylib.GetFrameTime()

  # Update objects
  game.update(dt)

  unless game.ready?
    player.update(dt)
    unless game.game_over?
      stage.update(dt)
      # Check collision : player vs stage
      hit, score = stage.hit?(player.pos, player.hit_radius)
      if hit
        game.finish
        player.finish
      end
      game.current_score += score
    end
  end

  # Render scene
  Raylib.BeginDrawing()
    Raylib.ClearBackground(stage.background_color)

    # Render objects
    stage.render
    player.render

    # Render UI
    # Event message
    msg_font_size = 35
    red = Raylib::Color.new(230, 41, 55, 255)
    if game.ready?
      text_widths = [
        Raylib.MeasureText('READY?', msg_font_size),
        Raylib.MeasureText('Space/Click to start', msg_font_size)
      ]
      q = game.state_timer.divmod(0.1)[0]
      Raylib.DrawText('READY?', 0.5 * screen_width - text_widths[0] * 0.5, 70, msg_font_size, red) if q % 2 == 0
      Raylib.DrawText('Space/Click to start', 0.5 * screen_width - text_widths[1] * 0.5, 130, msg_font_size, red) if q % 2 == 0
    elsif game.game_over?
      text_widths = [
        Raylib.MeasureText('GAME OVER', msg_font_size),
        Raylib.MeasureText('Space/Click to restart', msg_font_size)
      ]
      Raylib.DrawText('GAME OVER', 0.5 * screen_width - text_widths[0] * 0.5, 0.5 * screen_height - 30, msg_font_size, red)
      Raylib.DrawText('Space/Click to restart', 0.5 * screen_width - text_widths[1] * 0.5, 0.5 * screen_height + 30, msg_font_size, red) if game.state_timer > Game::STATE_GAMEOVER_DURATION
    end

    # Scores
    white = Raylib::Color.new(255, 255, 255, 255)
    Raylib.DrawText('1UP', 20, 10, 25, red)
    Raylib.DrawText("#{game.current_score}", 20, 35, 25, white)

    score_font_size = 25
    hiscore_header = 'HIGH SCORE'
    hiscore_header_width = Raylib.MeasureText(hiscore_header, score_font_size)
    hiscore_value = "%10d" % game.high_score
    hiscore_value_width = Raylib.MeasureText(hiscore_value, score_font_size)
    hiscore_value_offset = (hiscore_header_width - hiscore_value_width).abs

    hiscore_header_x = 0.5 * screen_width - hiscore_header_width * 0.5
    hiscore_value_x = hiscore_header_x + hiscore_value_offset
    Raylib.DrawText(hiscore_header, hiscore_header_x, 10, score_font_size, red)
    Raylib.DrawText(hiscore_value,  hiscore_value_x,  35, score_font_size, white)

    # Help message
    if game.ready?
      help_base_x = screen_width - 220
      help_base_y = screen_height - 100
      help_msg_x = help_base_x + 10
      help_msg_base_y = help_base_y + 10
      maroon = Raylib::Color.new(190, 33, 55, 255)
      gray = Raylib::Color.new(130, 130, 130, 255)
      Raylib.DrawRectangle(help_base_x, help_base_y, 205, 80, Raylib.Fade(maroon, 0.8))
      Raylib.DrawRectangleLines(help_base_x, help_base_y, 205, 80, gray)
      Raylib.DrawText('Space/Click : jump', help_msg_x, help_msg_base_y + 0, 20, white)
      Raylib.DrawText('R : restart game', help_msg_x, help_msg_base_y + 20, 20, white)
      Raylib.DrawText('ESC : exit', help_msg_x, help_msg_base_y + 40, 20, white)
    end
  Raylib.EndDrawing()
end

Raylib.CloseWindow()
