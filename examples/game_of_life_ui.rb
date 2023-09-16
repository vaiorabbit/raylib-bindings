=begin
Usage:
- Mouse Left : Draw
- Mouse Left + Shift : Erase
- Space : Run/Pause simulation
- C : Clear
- F : Show/Hide FPS counter
- G : Show/Hide Grid
- U : Show/Hide controller UI
=end

require_relative 'util/setup_dll'

class GameOfLife
  attr_reader :cell_width, :cell_height, :row_count, :col_count

  def initialize(cell_width, cell_height, row_count, col_count)
    raise ArgumentError unless (row_count >= 3 and col_count >= 3)
    @cell_width = cell_width
    @cell_height = cell_height
    @row_count = row_count
    @col_count = col_count
    @grid_now = Array.new(row_count) { Array.new (col_count) { 0 } }
    @grid_new = Array.new(row_count) { Array.new (col_count) { 0 } }
  end

  def update
    update_grid
    @grid_now, @grid_new = @grid_new, @grid_now
  end

  def clear_grid
    @grid_now = Array.new(row_count) { Array.new (col_count) { 0 } }
    @grid_new = Array.new(row_count) { Array.new (col_count) { 0 } }
  end

  def set_grid(row_index, col_index, value)
    @grid_now[row_index][col_index] = value
  end

  def render
    @grid_now.each_with_index do |row_cells, row|
      row_cells.each_with_index do |cell, col|
        DrawRectangle(col * @cell_width, row * @cell_height, @cell_width, @cell_height, WHITE) if cell == 1
      end
    end
  end

  private
  def get_alive_count(r, c)
    row_length = @grid_now.length
    col_length = @grid_now[0].length
    w = c - 1                # west
    e = (c + 1) % col_length # east
    n = r - 1                # north
    s = (r + 1) % row_length # south
    # Count # of alive cells surrounding @grid_now[r][c]
    @grid_now[n][w] + @grid_now[n][c] + @grid_now[n][e] +
    @grid_now[r][w] +                   @grid_now[r][e] +
    @grid_now[s][w] + @grid_now[s][c] + @grid_now[s][e]
  end

  private
  def update_grid
    @grid_now.each_with_index do |row_cells, row|
      row_cells.each_with_index do |cell, col|
        @grid_new[row][col] = case get_alive_count(row, col)
                              when 0, 1; 0                # 0 or 1 -> delete current cell
                              when 2; @grid_now[row][col] # 2      -> keep current cell status
                              when 3; 1                   # 3      -> put new cell
                              else; 0                     # > 4    -> delete current cell
                              end
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  screen_width = 1280
  screen_height = 1280
  InitWindow(screen_width, screen_height, "Yet Another Ruby-raylib bindings - Game of Life")
  SetTargetFPS(60)

  font_size = 48
  font = LoadFontEx("jpfont/x12y16pxMaruMonica.ttf", font_size, nil, 65535)
  SetTextureFilter(font.texture, TEXTURE_FILTER_POINT)
  GuiSetFont(font)

  cell_width = 18
  cell_height = 18
  row_count = screen_height / cell_height
  col_count = screen_width / cell_width

  gol = GameOfLife.new(cell_width, cell_height, row_count, col_count)

  interval = 1
  exec_update = false
  update_count = interval

  clear_grid = false

  show_fps = true
  show_grid = true
  show_ui = true

  ui_base_x = 720
  ui_base_y = 900
  ui_space_x = 20
  ui_space_y = 20
  ui_line_height = font_size + 10
  ui_area = Rectangle.create(ui_base_x, ui_base_y, 550, 2 * ui_space_y + 5 * ui_line_height)

  until WindowShouldClose()
    exec_update = !exec_update if IsKeyPressed(KEY_SPACE)
    show_fps = !show_fps if IsKeyPressed(KEY_F)
    show_grid = !show_grid if IsKeyPressed(KEY_G)
    show_ui = !show_ui if IsKeyPressed(KEY_U)
    clear_grid = true if IsKeyPressed(KEY_C)

    if IsMouseButtonDown(MOUSE_BUTTON_LEFT)
      mouse_pos = GetMousePosition()
      on_ui = show_ui && CheckCollisionPointRec(mouse_pos, ui_area)
      unless on_ui
        erase_mode = (IsKeyDown(KEY_LEFT_SHIFT) || IsKeyDown(KEY_RIGHT_SHIFT))
        col_index = (mouse_pos.x / gol.cell_width).clamp(0, gol.col_count - 1)
        row_index = (mouse_pos.y / gol.cell_height).clamp(0, gol.row_count - 1)
        gol.set_grid(row_index, col_index, erase_mode ? 0 : 1)
      end
    end

    if exec_update
      if update_count <= 0
        gol.update
        update_count = interval
      else
        update_count -= 1
      end
    end

    BeginDrawing()
    ClearBackground(BLACK)

    gol.render

    if show_grid
      line_height = gol.row_count * gol.cell_height
      (gol.col_count + 1).times do |col|
        DrawLine(col * gol.cell_width, 0, col * gol.cell_width, line_height, DARKGRAY)
      end
      line_width = gol.col_count * gol.cell_width
      (gol.row_count + 1).times do |row|
        DrawLine(0, row * gol.cell_height, line_width, row * gol.cell_height, DARKGRAY)
      end
    end

    if show_ui
      DrawRectangleRec(ui_area, Fade(WHITE, 0.9))

      widget_x = ui_base_x + ui_space_x
      widget_base_y = ui_base_y + ui_space_y
      exec_update, result = RGuiCheckBox(Rectangle.create(widget_x, widget_base_y + ui_line_height * 0, font_size, font_size), "Run (#{exec_update ? 'ON' : 'OFF'})", exec_update)
      interval, result = RGuiSliderBar(  Rectangle.create(widget_x, widget_base_y + ui_line_height * 1, 300, font_size), nil, " Interval (#{interval})", interval, 0, 20)
      show_fps, result = RGuiCheckBox(   Rectangle.create(widget_x, widget_base_y + ui_line_height * 2, font_size, font_size), "Show FPS(#{show_fps ? 'ON' : 'OFF'})", show_fps)
      show_grid, result = RGuiCheckBox(  Rectangle.create(widget_x, widget_base_y + ui_line_height * 3, font_size, font_size), "Show Grid(#{show_grid ? 'ON' : 'OFF'})", show_grid)
      clear_grid = GuiButton(    Rectangle.create(widget_x, widget_base_y + ui_line_height * 4, font_size * 10, font_size), 'Clear Grid') == 1

      interval = interval.to_i
    end
    DrawFPS(screen_width - 100, 16) if show_fps

    EndDrawing()

    if clear_grid
      exec_update = false
      gol.clear_grid
    end

  end
  CloseWindow()
end
