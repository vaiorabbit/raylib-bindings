require_relative 'util/setup_dll'

class Reversi
  attr_reader :row_count, :col_count, :current_color, :game_status

  BOARD_GRIDS_W = 8
  BOARD_GRIDS_H = 8

  STATUS_PLAYING = 0
  STATUS_FINISH = 1

  GRID_BLACK = 0
  GRID_WHITE = 1
  GRID_EMPTY = -1

  DIR_UL = 0
  DIR_U  = 1
  DIR_UR = 2
  DIR_L  = 3
  DIR_R  = 4
  DIR_DL = 5
  DIR_D  = 6
  DIR_DR = 7
  DIR_COUNT = 8

  DIRS = [
    [-1, -1], # DIR_UL
    [ 0, -1], # DIR_U
    [ 1, -1], # DIR_UR
    [-1,  0], # DIR_L
    [ 1,  0], # DIR_R
    [-1,  1], # DIR_DL
    [ 0,  1], # DIR_D
    [ 1,  1]  # DIR_DR
  ].freeze

  class Grid
    attr_accessor :color

    def initialize
      @color = GRID_EMPTY
    end
  end

  def initialize
    @row_count = Reversi::BOARD_GRIDS_H
    @col_count = Reversi::BOARD_GRIDS_W
    reset_game
  end

  def switch_turn = @current_color ^= 1

  def finish = @game_status = STATUS_FINISH

  def finished? = @game_status == STATUS_FINISH

  def grid = @grid_now;

  def reset_game
    @grid_now = Array.new(@row_count) { Array.new (@col_count) { Grid.new } }
    @grid_now[3][3].color = GRID_WHITE
    @grid_now[4][4].color = GRID_WHITE
    @grid_now[3][4].color = GRID_BLACK
    @grid_now[4][3].color = GRID_BLACK

    @current_color = GRID_BLACK
    @game_status = STATUS_PLAYING
  end

  def set_grid(row_index, col_index, color) = @grid_now[row_index][col_index].color = color

  def grid_empty?(row_index, col_index) = @grid_now[row_index][col_index].color == GRID_EMPTY

  def get_color_count(color)
    point = 0
    @grid_now.each_with_index do |row_grids, row|
      row_grids.each_with_index do |grid, col|
        point += 1 if grid.color == color
      end
    end
    point
  end

  def row_out_of_range?(row_index) = (row_index < 0 || row_index >= @row_count)

  def col_out_of_range?(col_index) = (col_index < 0 || col_index >= @col_count)

  def out_of_range?(row_index, col_index) = (row_out_of_range?(row_index) || col_out_of_range?(col_index))

  def get_color(row_index, col_index) = @grid_now[row_index][col_index].color

  def grid_placeable?(row_index:, col_index:, check_color:)
    return false if out_of_range?(row_index, col_index)
    return false unless grid_empty?(row_index, col_index)
    return false unless (check_color == GRID_BLACK || check_color == GRID_WHITE)

    placeable = false

    enemy_color = check_color ^ 1

    DIRS.each do |dir|
      check_row, check_col = row_index + dir[0], col_index + dir[1]
      next if out_of_range?(check_row, check_col) || get_color(check_row, check_col) != enemy_color

      loop do
        check_row, check_col = check_row + dir[0], check_col + dir[1]
        break if out_of_range?(check_row, check_col) || grid_empty?(check_row, check_col)

        if get_color(check_row, check_col) == check_color
          placeable = true
          break
        end
      end
      break if placeable
    end

    return placeable
  end

  def collect_reversible_grids(row_index, col_index, check_color)
    return [] unless grid_placeable?(row_index: row_index, col_index: col_index, check_color: check_color)

    reversible_grids = []

    enemy_color = check_color ^ 1

    DIRS.each do |dir|
      check_row, check_col = row_index + dir[0], col_index + dir[1]
      next if out_of_range?(check_row, check_col) || get_color(check_row, check_col) != enemy_color

      loop do
        check_row, check_col = check_row + dir[0], check_col + dir[1]
        break if out_of_range?(check_row, check_col) || grid_empty?(check_row, check_col)

        if get_color(check_row, check_col) == check_color
          reversible_row, reversible_col = row_index + dir[0], col_index + dir[1]
          loop do
            reversible_grids << @grid_now[reversible_row][reversible_col]
            reversible_row, reversible_col = reversible_row + dir[0], reversible_col + dir[1]
            break if @grid_now[reversible_row][reversible_col].color != enemy_color
          end
        end
      end
    end

    reversible_grids
  end

  def placeable_grids
    black_placeable = []
    white_placeable = []

    @row_count.times do |r|
      @col_count.times do |c|
        black_placeable << @grid_now[r][c] if grid_placeable?(row_index: r, col_index: c, check_color: GRID_BLACK)
        white_placeable << @grid_now[r][c] if grid_placeable?(row_index: r, col_index: c, check_color: GRID_WHITE)
      end
    end

    [black_placeable, white_placeable]
  end


  def grid_placeable_current_color?(row_index:, col_index:)
    grid_placeable?(row_index: row_index, col_index: col_index, check_color: @current_color)
  end

  def set_grid_and_reverse(row_index, col_index)
    reversible_grids = collect_reversible_grids(row_index, col_index, @current_color)
    set_grid(row_index, col_index, @current_color)
    reversible_grids.each do |grid|
      grid.color = @current_color
    end
  end

  def switch_turn_or_finish
    switch_turn
    black_placeable, white_placeable = placeable_grids
    if black_placeable.empty? && white_placeable.empty?
      finish
    elsif black_placeable.empty?
      switch_turn if @current_color == Reversi::GRID_BLACK
    elsif white_placeable.empty?
      switch_turn if @current_color == Reversi::GRID_WHITE
    end
  end

  def advance_turn(row_index, col_index)
    set_grid_and_reverse(row_index, col_index)
    switch_turn_or_finish
  end
end


class GUI
  attr_accessor :screen_width, :screen_height
  attr_reader :cell_width, :cell_height, :reset_game_pressed

  def initialize(reversi:, cell_width:, cell_height:, screen_width:, screen_height:, font_size:)
    @reversi = reversi
    @cell_width = cell_width
    @cell_height = cell_height
    @cell_radius = 0.5 * [@cell_width, @cell_height].min

    @screen_width = screen_width
    @screen_height = screen_height
    @font_size = font_size

    @font = LoadFontEx("jpfont/x12y16pxMaruMonica.ttf", @font_size, nil, 65535)
    SetTextureFilter(@font.texture, TEXTURE_FILTER_POINT)
    GuiSetFont(@font)
    GuiSetStyle(DEFAULT, TEXT_SIZE, @font_size)

    spacing = 10
    @ui_base_x, @ui_base_y = 0, @cell_height * Reversi::BOARD_GRIDS_H + spacing
    @ui_space_x, @ui_space_y = spacing, spacing
    @ui_height_per_line = @font_size + 4
    @ui_area = Rectangle.create(@ui_base_x, @ui_base_y, @cell_width * Reversi::BOARD_GRIDS_W, 2 * @ui_space_y + 4.5 * @ui_height_per_line)

    @current_language = Messages::LANG_EN
    @msg = Messages.new(language: @current_language)

    @reset_game_pressed = false
  end

  def render
    # render grid
    line_height = @reversi.row_count * @cell_height
    (@reversi.col_count + 1).times do |col|
      DrawLine(col * @cell_width, 0, col * @cell_width, line_height, DARKGRAY)
    end
    line_width = @reversi.col_count * @cell_width
    (@reversi.row_count + 1).times do |row|
      DrawLine(0, row * @cell_height, line_width, row * @cell_height, DARKGRAY)
    end

    # render stones
    @reversi.grid.each_with_index do |row_grids, row|
      row_grids.each_with_index do |grid, col|
        next if grid.color == Reversi::GRID_EMPTY
        DrawCircle(col * @cell_width + @cell_radius, row * @cell_height + @cell_radius, @cell_radius, grid.color == Reversi::GRID_BLACK ? BLACK : WHITE)
      end
    end

    # UI
    black_count = @reversi.get_color_count(Reversi::GRID_BLACK)
    white_count = @reversi.get_color_count(Reversi::GRID_WHITE)
    status_message = if @reversi.finished?
                       if black_count > white_count
                         "#{@msg.get(Messages::ID::GAME_FINISHED_WINNER)} > ■#{@msg.get(Messages::ID::BLACK)}"
                       elsif black_count < white_count
                         "#{@msg.get(Messages::ID::GAME_FINISHED_WINNER)} > □#{@msg.get(Messages::ID::WHITE)}"
                       else
                         "#{@msg.get(Messages::ID::GAME_FINISHED_DRAW)}"
                       end
                     else
                       "#{@msg.get(Messages::ID::TURN)}: #{@reversi.current_color == Reversi::GRID_BLACK ? '■' + @msg.get(Messages::ID::BLACK) : '□' + @msg.get(Messages::ID::WHITE)}"
                     end

    score_message = "[#{@msg.get(Messages::ID::SCORE)}] ■#{@msg.get(Messages::ID::BLACK)}: #{black_count} / □#{@msg.get(Messages::ID::WHITE)}: #{white_count}"

    DrawRectangleRec(@ui_area, Fade(WHITE, 0.9))
    widget_x = @ui_base_x + @ui_space_x
    widget_base_y = @ui_base_y + @ui_space_y
    GuiLabel(Rectangle.create(widget_x, widget_base_y + @ui_height_per_line * 0, @ui_area.width - 2 * @ui_space_x, @font_size), status_message)
    DrawLine(0, widget_base_y + @ui_height_per_line * 1, @ui_area.width, widget_base_y + @ui_height_per_line * 1, GRAY)
    GuiLabel(Rectangle.create(widget_x, widget_base_y + @ui_height_per_line * 1, @ui_area.width - 2 * @ui_space_x, @font_size), score_message)
    @reset_game_pressed = GuiButton(Rectangle.create(widget_x, widget_base_y + @ui_height_per_line * 2, @ui_area.width - 2 * @ui_space_x, @font_size * 1.5), "#{@msg.get(Messages::ID::RESET_GAME)}") == 1

    GuiLabel(Rectangle.create(widget_x, widget_base_y + @ui_height_per_line * 3.5, @ui_area.width - 2 * @ui_space_x, @font_size), "#{@msg.get(Messages::ID::LANGUAGE)}:")

    msg_length = MeasureText("#{@msg.get(Messages::ID::LANGUAGE)}:", @font_size)
    msg_scale = @current_language == Messages::LANG_JA ? 2 : 1;
    @current_language, result = RGuiToggleSlider(Rectangle.create(widget_x + msg_scale * msg_length, widget_base_y + @ui_height_per_line * 3.5, msg_scale * msg_length * 2, @font_size), "English;日本語", @current_language)
    @msg.current_language = @current_language if result != 0

  end

  def point_on_ui(mouse_pos)
    CheckCollisionPointRec(mouse_pos, @ui_area)
  end

  def position_to_board_rowcol(mouse_pos)
    col_index = (mouse_pos.x / @cell_width).clamp(0, @reversi.col_count - 1)
    row_index = (mouse_pos.y / @cell_height).clamp(0, @reversi.row_count - 1)
    [row_index, col_index]
  end
end


class Messages
  attr_accessor :current_language

  LANG_EN = 0
  LANG_JA = 1

  def initialize(language: LANG_EN)
    @current_language = language
    @msgs = {
      :game_finished_winner => ['Game finished. Winner', 'ゲーム終了 勝者'],
      :game_finished_draw => ['Game finished. Result > Draw', 'ゲーム終了 > 引き分け'],
      :black => ['Black', '黒'],
      :white => ['White', '白'],
      :turn => ['Turn', '順番'],
      :score => ['Score', 'スコア'],
      :reset_game => ['Reset Game', 'ゲームをリセット'],
      :language => ['Language', '言語'],
    }
    Messages.const_set('ID', Module.new)
    @msgs.keys.each do |sym|
      ID.const_set(sym.to_s.upcase!, sym)
    end
  end

  def get(id) = @msgs[id][@current_language];
end


if __FILE__ == $PROGRAM_NAME
  reversi = Reversi.new

  cell_width, cell_height = 48, 48
  font_size = 24
  screen_width = cell_width * Reversi::BOARD_GRIDS_W
  screen_height = cell_height * Reversi::BOARD_GRIDS_H + font_size * 6.5
  InitWindow(screen_width, screen_height, "Ruby-raylib bindings - Reversi")
  gui = GUI.new(reversi: reversi, cell_width: cell_width, cell_height: cell_height, screen_width: screen_width, screen_height: screen_height, font_size: 24)

  SetTargetFPS(60)
  until WindowShouldClose()
    mouse_pos = GetMousePosition()
    row, col = gui.position_to_board_rowcol(mouse_pos)
    advance_turn =                                                              # If
      !reversi.finished? &&                                                     # - Not finished yet
      IsMouseButtonPressed(MOUSE_BUTTON_LEFT) && !gui.point_on_ui(mouse_pos) && # - Player clicked on Reversi board
      reversi.grid_placeable_current_color?(row_index: row, col_index: col)     # - Current player can put stone on this position
    reversi.advance_turn(row, col) if advance_turn                              # Then advance the game

    BeginDrawing()
      ClearBackground(DARKGREEN)
      gui.render
    EndDrawing()

    reversi.reset_game if gui.reset_game_pressed
  end

  CloseWindow()
end
