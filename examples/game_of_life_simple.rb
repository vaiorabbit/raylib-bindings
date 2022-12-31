require_relative 'util/setup_dll'

def get_alive_count(grid, r, c)
  row_length = grid.length
  col_length = grid[0].length
  w = c - 1                # west
  e = (c + 1) % col_length # east
  n = r - 1                # north
  s = (r + 1) % row_length # south
  # Count # of alive cells surrounding grid[r][c]
  grid[n][w] + grid[n][c] + grid[n][e] +
  grid[r][w] +              grid[r][e] +
  grid[s][w] + grid[s][c] + grid[s][e]
end

def update_grid(grid_now, grid_new)
  grid_now.each_with_index do |row_cells, row|
    row_cells.each_with_index do |cell, col|
      grid_new[row][col] = case get_alive_count(grid_now, row, col)
                           when 0, 1; 0               # 0 or 1 -> delete current cell
                           when 2; grid_now[row][col] # 2      -> keep current cell status
                           when 3; 1                  # 3      -> put new cell
                           else; 0                    # > 4    -> delete current cell
                           end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  screen_width = 1280
  screen_height = 1280
  InitWindow(screen_width, screen_height, "Yet Another Ruby-raylib bindings - Game of Life")
  SetTargetFPS(60)

  cell_width = 18
  cell_height = 18
  row_count = screen_height / cell_height
  col_count = screen_width / cell_width

  grid_now = Array.new(row_count) { Array.new (col_count) { 0 } }
  grid_new = Array.new(row_count) { Array.new (col_count) { 0 } }

  interval = 1
  exec_update = false
  update_count = interval

  until WindowShouldClose()
    exec_update = !exec_update if IsKeyPressed(KEY_SPACE)

    if IsMouseButtonDown(MOUSE_BUTTON_LEFT)
      mouse_x, mouse_y = GetMouseX(), GetMouseY()
      col_index = (mouse_x / cell_width).clamp(0, col_count - 1)
      row_index = (mouse_y / cell_height).clamp(0, row_count - 1)
      grid_now[row_index][col_index] = 1
    end

    if exec_update
      if update_count <= 0
        update_grid(grid_now, grid_new)
        grid_now, grid_new = grid_new, grid_now
        update_count = interval
      else
        update_count -= 1
      end
    end

    BeginDrawing()
    ClearBackground(BLACK)

    grid_now.each_with_index do |row_cells, row|
      row_cells.each_with_index do |cell, col|
        DrawRectangle(col * cell_width, row * cell_height, cell_width, cell_height, WHITE) if cell == 1
      end
    end

    line_height = row_count * cell_height
    (col_count + 1).times do |col|
      DrawLine(col * cell_width, 0, col * cell_width, line_height, DARKGRAY)
    end
    line_width = col_count * cell_width
    (row_count + 1).times do |row|
      DrawLine(0, row * cell_height, line_width, row * cell_height, DARKGRAY)
    end

    DrawFPS(screen_width - 100, 16)
    EndDrawing()

  end
  CloseWindow()
end
