require_relative 'util/setup_dll'

class Reversi
  attr_reader :cell_width, :cell_height, :row_count, :col_count, :current_color, :game_status

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
    @cell_width = 40
    @cell_height = 40
    @cell_radius = 0.5 * [@cell_width, @cell_height].min
    @row_count = Reversi::BOARD_GRIDS_H
    @col_count = Reversi::BOARD_GRIDS_W
    reset_game
  end

  def switch_turn = @current_color ^= 1

  def finish = @game_status = STATUS_FINISH

  def finished? = @game_status == STATUS_FINISH

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

  def render
    # render grid
    line_height = @row_count * @cell_height
    (@col_count + 1).times do |col|
      DrawLine(col * @cell_width, 0, col * @cell_width, line_height, DARKGRAY)
    end
    line_width = @col_count * @cell_width
    (@row_count + 1).times do |row|
      DrawLine(0, row * @cell_height, line_width, row * @cell_height, DARKGRAY)
    end

    # render stones
    @grid_now.each_with_index do |row_grids, row|
      row_grids.each_with_index do |grid, col|
        next if grid.color == GRID_EMPTY
        DrawCircle(col * @cell_width + @cell_radius, row * @cell_height + @cell_radius, @cell_radius, grid.color == GRID_BLACK ? BLACK : WHITE)
      end
    end
  end

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

  def grid_placeable?(row_index, col_index, check_color)
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
    return [] unless grid_placeable?(row_index, col_index, check_color)

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
        black_placeable << @grid_now[r][c] if grid_placeable?(r, c, GRID_BLACK)
        white_placeable << @grid_now[r][c] if grid_placeable?(r, c, GRID_WHITE)
      end
    end

    [black_placeable, white_placeable]
  end
end

if __FILE__ == $PROGRAM_NAME
  reversi = Reversi.new

  font_size = 16
  screen_width = reversi.cell_width * Reversi::BOARD_GRIDS_W
  screen_height = reversi.cell_height * Reversi::BOARD_GRIDS_H + font_size * 7
  InitWindow(screen_width, screen_height, "Ruby-raylib bindings - Reversi")

  font = LoadFontEx("jpfont/x12y16pxMaruMonica.ttf", font_size, nil, 65535)
  SetTextureFilter(font[:texture], TEXTURE_FILTER_POINT)
  GuiSetFont(font)

  SetTargetFPS(60)

  ui_base_x, ui_base_y = 0, reversi.cell_height * Reversi::BOARD_GRIDS_H + 10
  ui_space_x, ui_space_y = 10, 10
  ui_line_height = font_size + 4
  ui_area = Rectangle.create(ui_base_x, ui_base_y, reversi.cell_width * Reversi::BOARD_GRIDS_W, 2 * ui_space_y + 3 * ui_line_height)

  until WindowShouldClose()
    mouse_pos = GetMousePosition()
    col_index = (mouse_pos.x / reversi.cell_width).clamp(0, reversi.col_count - 1)
    row_index = (mouse_pos.y / reversi.cell_height).clamp(0, reversi.row_count - 1)
    color = reversi.current_color
    if !reversi.finished? && IsMouseButtonDown(MOUSE_BUTTON_LEFT) && reversi.grid_placeable?(row_index, col_index, color)
      on_ui = CheckCollisionPointRec(mouse_pos, ui_area)
      unless on_ui
        reversible_grids = reversi.collect_reversible_grids(row_index, col_index, color)
        reversi.set_grid(row_index, col_index, color)
        reversible_grids.each do |grid|
          grid.color = color
        end
        reversi.switch_turn

        black_placeable, white_placeable = reversi.placeable_grids()
        if black_placeable.empty? && white_placeable.empty?
          reversi.finish
        elsif black_placeable.empty?
          reversi.switch_turn if reversi.current_color == Reversi::GRID_BLACK
        elsif white_placeable.empty?
          reversi.switch_turn if reversi.current_color == Reversi::GRID_WHITE
        end
      end
    end

    BeginDrawing()
    ClearBackground(DARKGREEN)

    reversi.render

    black_count = reversi.get_color_count(Reversi::GRID_BLACK)
    white_count = reversi.get_color_count(Reversi::GRID_WHITE)
    status_message = if reversi.finished?
                       if black_count > white_count
                         'Game finished. Winner > ■Black'
                       elsif black_count < white_count
                         'Game finished. Winner > □White'
                       else
                         'Game finished. Result > Draw'
                       end
                     else
                       "Turn: #{reversi.current_color == Reversi::GRID_BLACK ? '■Black' : '□White'}"
                     end

    score_message = "[Score] ■Black: #{black_count} / □White: #{white_count}"

    DrawRectangleRec(ui_area, Fade(WHITE, 0.9))
    widget_x = ui_base_x + ui_space_x
    widget_base_y = ui_base_y + ui_space_y
    GuiLabel(Rectangle.create(widget_x, widget_base_y + ui_line_height * 0, ui_area.width - 2 * ui_space_x, font_size), status_message)
    DrawLine(0, widget_base_y + ui_line_height * 1, ui_area.width, widget_base_y + ui_line_height * 1, GRAY)
    GuiLabel(Rectangle.create(widget_x, widget_base_y + ui_line_height * 1, ui_area.width - 2 * ui_space_x, font_size), score_message)
    clear_grid = GuiButton(   Rectangle.create(widget_x, widget_base_y + ui_line_height * 2, ui_area.width - 2 * ui_space_x, font_size * 1.5), 'Reset Game')
    EndDrawing()

    reversi.reset_game if clear_grid
  end

  CloseWindow()
end
