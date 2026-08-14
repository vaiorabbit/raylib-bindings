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

# The generated mruby bindings take DATA objects for C pointer arguments.
# But there's no FFI available on mruby environment.
# So we reuse GuiStyleProp and Vector2 as small writable int/float holders,
# following the same trick used in code_gui_controls.rb.
class IntHolder
  attr_accessor :buffer

  def initialize(value = 0)
    @buffer = Raylib::GuiStyleProp.new(value, 0, 0)
  end

  def value
    @buffer.controlId
  end

  def value=(v)
    @buffer.controlId = v
  end
end

class FloatHolder
  attr_accessor :buffer

  def initialize(value = 0)
    @buffer = Raylib::Vector2.new(value, 0.0)
  end

  def value
    @buffer.x
  end

  def value=(v)
    @buffer.x = v
  end
end


class GameOfLife
  attr_reader :row_count, :col_count

  def initialize(row_count, col_count)
    raise ArgumentError unless (row_count >= 3 and col_count >= 3)
    @row_count = row_count
    @col_count = col_count
    @grid_now = Array.new(row_count) { Array.new (col_count) { 0 } }
    @grid_new = Array.new(row_count) { Array.new (col_count) { 0 } }
  end

  def current_grid = @grid_now;

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


class GUI
  attr_accessor :screen_width, :screen_height, :exec_update, :show_ui, :show_fps, :show_grid
  attr_reader :cell_width, :cell_height, :interval, :clear_grid_pressed

  def initialize(gol:, cell_width:, cell_height:, screen_width:, screen_height:, font_size:)
    @gol = gol
    @cell_width = cell_width
    @cell_height = cell_height

    @screen_width = screen_width
    @screen_height = screen_height
    @font_size = font_size

    @interval = 1
    @exec_update = false
    @show_ui = true
    @show_fps = true
    @show_grid = true
    @clear_grid_pressed = false

    # FIXME
    # - Current raygui mruby bindings cannot handle nil passed via arguments (cause runtime crash)
    # - The ype of @font.txture is wrong (TrueClass, should be Raylib::Textrue)
    # @font = Raylib.LoadFontEx("jpfont/x12y16pxMaruMonica.ttf", font_size, nil, 65535)
#    @font = Raylib.LoadFont("jpfont/x12y16pxMaruMonica.ttf")
    # FIXME
    # - The ype of @font.txture is wrong (TrueClass, should be Raylib::Textrue)
    # Raylib.SetTextureFilter(@font.texture, Raylib::TEXTURE_FILTER_POINT)
#    Raylib.GuiSetFont(@font)
#    Raylib.GuiSetStyle(Raylib::DEFAULT, Raylib::TEXT_SIZE, @font_size)

    @run_checked = IntHolder.new(@exec_update ? 1 : 0)
    @interval_value = FloatHolder.new(@interval)
    @show_fps_checked = IntHolder.new(@show_fps ? 1 : 0)
    @show_grid_checked = IntHolder.new(@show_grid ? 1 : 0)

    @ui_space_x = 20
    @ui_space_y = 20
    @ui_line_height = @font_size + 10

    @ui_rect_w = 450
    @ui_rect_h = 2 * @ui_space_y + 5 * @ui_line_height
    @ui_base_x = @screen_width - @ui_rect_w - @ui_space_x
    @ui_base_y = @screen_height - @ui_rect_h - @ui_space_y
    @ui_area = Raylib::Rectangle.new(@ui_base_x, @ui_base_y, @ui_rect_w, @ui_rect_h)
  end

  def render
    # Grid
    if @show_grid
      darkgray = Raylib::Color.new(80, 80, 80, 255)
      line_height = @gol.row_count * @cell_height
      (@gol.col_count + 1).times do |col|
        Raylib.DrawLine(col * @cell_width, 0, col * @cell_width, line_height, darkgray)
      end
      line_width = @gol.col_count * @cell_width
      (@gol.row_count + 1).times do |row|
        Raylib.DrawLine(0, row * @cell_height, line_width, row * @cell_height, darkgray)
      end
    end

    # Cells
    white = Raylib::Color.new(255, 255, 255, 255)
    @gol.current_grid.each_with_index do |row_cells, row|
      row_cells.each_with_index do |cell, col|
        Raylib.DrawRectangle(col * @cell_width, row * @cell_height, @cell_width, @cell_height, white) if cell == 1
      end
    end

    # Control
    if @show_ui
      Raylib.DrawRectangleRec(@ui_area, Raylib.Fade(white, 0.9))
      widget_x = @ui_base_x + @ui_space_x
      widget_base_y = @ui_base_y + @ui_space_y

      @run_checked.value = @exec_update ? 1 : 0
      Raylib.GuiCheckBox(Raylib::Rectangle.new(widget_x, widget_base_y + @ui_line_height * 0, @font_size, @font_size), "Run (#{@exec_update ? 'ON' : 'OFF'})", @run_checked.buffer)
      @exec_update = (@run_checked.value != 0)

      Raylib.GuiSliderBar(Raylib::Rectangle.new(widget_x, widget_base_y + @ui_line_height * 1, 300, @font_size), '', " Interval (#{@interval})", @interval_value.buffer, 0.0, 20.0)
      @interval = @interval_value.value.to_i

      @show_fps_checked.value = @show_fps ? 1 : 0
      Raylib.GuiCheckBox(Raylib::Rectangle.new(widget_x, widget_base_y + @ui_line_height * 2, @font_size, @font_size), "Show FPS(#{@show_fps ? 'ON' : 'OFF'})", @show_fps_checked.buffer)
      @show_fps = (@show_fps_checked.value != 0)

      @show_grid_checked.value = @show_grid ? 1 : 0
      Raylib.GuiCheckBox(Raylib::Rectangle.new(widget_x, widget_base_y + @ui_line_height * 3, @font_size, @font_size), "Show Grid(#{@show_grid ? 'ON' : 'OFF'})", @show_grid_checked.buffer)
      @show_grid = (@show_grid_checked.value != 0)

      @clear_grid_pressed = Raylib.GuiButton(Raylib::Rectangle.new(widget_x, widget_base_y + @ui_line_height * 4, @font_size * 10, @font_size), 'Clear Grid') != 0
    end

    # Stat
    Raylib.DrawFPS(@screen_width - 100, 16) if @show_fps
  end

  def point_on_ui(mouse_pos)
    Raylib.CheckCollisionPointRec(mouse_pos, @ui_area)
  end
end


screen_width = 720
screen_height = 720

Raylib.InitWindow(screen_width, screen_height, "Yet Another Ruby-raylib bindings - Game of Life")
Raylib.SetTargetFPS(60)

cell_width = 18
cell_height = 18
row_count = screen_height / cell_height
col_count = screen_width / cell_width

gol = GameOfLife.new(row_count, col_count)
gui = GUI.new(gol: gol, cell_width: cell_width, cell_height: cell_height, screen_width: screen_width, screen_height: screen_height, font_size: 24)

sleep_count = gui.interval

until Raylib.WindowShouldClose()
  gui.exec_update = !gui.exec_update if Raylib.IsKeyPressed(Raylib::KEY_SPACE)
  gui.show_ui = !gui.show_ui if Raylib.IsKeyPressed(Raylib::KEY_U)
  gui.show_fps = !gui.show_fps if Raylib.IsKeyPressed(Raylib::KEY_F)
  gui.show_grid = !gui.show_grid if Raylib.IsKeyPressed(Raylib::KEY_G)

  if Raylib.IsMouseButtonDown(Raylib::MOUSE_BUTTON_LEFT)
    mouse_pos = Raylib.GetMousePosition()
    on_ui = gui.show_ui && gui.point_on_ui(mouse_pos)
    unless on_ui
      erase_mode = (Raylib.IsKeyDown(Raylib::KEY_LEFT_SHIFT) || Raylib.IsKeyDown(Raylib::KEY_RIGHT_SHIFT))
      col_index = (mouse_pos.x / gui.cell_width).to_i.clamp(0, gol.col_count - 1)
      row_index = (mouse_pos.y / gui.cell_height).to_i.clamp(0, gol.row_count - 1)
      gol.set_grid(row_index, col_index, erase_mode ? 0 : 1)
    end
  end

  if gui.exec_update
    if sleep_count <= 0
      gol.update
      sleep_count = gui.interval
    else
      sleep_count -= 1
    end
  end

  Raylib.BeginDrawing()
  Raylib.ClearBackground(Raylib::Color.new(0, 0, 0, 255))
    gui.render
  Raylib.EndDrawing()

  clear_grid = (Raylib.IsKeyPressed(Raylib::KEY_C) || gui.clear_grid_pressed)
  if clear_grid
    gui.exec_update = false
    gol.clear_grid
  end
end

Raylib.CloseWindow()
