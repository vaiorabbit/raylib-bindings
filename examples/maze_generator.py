# Constants for window size and grid dimensions
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600
CELL_SIZE = 30
GRID_ROWS = WINDOW_HEIGHT // CELL_SIZE
GRID_COLS = WINDOW_WIDTH // CELL_SIZE

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
GREEN = (0, 255, 0)

>>>>>>> maze_generation_implementation
import pygame
import random

# Initialize Pygame
pygame.init()

def init_grid():
    """Initializes the grid with walls and sets all cells as unvisited."""
    grid = [['wall' for _ in range(GRID_COLS)] for _ in range(GRID_ROWS)]
    return grid

def remove_wall(grid, current_cell, next_cell):
    """Removes wall between two adjacent cells."""
    cx, cy = current_cell
    nx, ny = next_cell

    if cx == nx:
        # Horizontal movement
        wall_x = (cx + nx) // 2
        wall_y = cy
        grid[wall_y][wall_x] = 'path'
    elif cy == ny:
        # Vertical movement
        wall_x = cx
        wall_y = (cy + ny) // 2
        grid[wall_y][wall_x] = 'path'

def get_neighbors(grid, cell):
    """Returns list of unvisited neighbors for a given cell."""
    x, y = cell
    neighbors = []
    if x > 0 and grid[y][x - 1] == 'wall':  # Left neighbor
        neighbors.append((x - 1, y))
    if x < GRID_COLS - 1 and grid[y][x + 1] == 'wall':  # Right neighbor
        neighbors.append((x + 1, y))
    if y > 0 and grid[y - 1][x] == 'wall':  # Upper neighbor
        neighbors.append((x, y - 1))
    if y < GRID_ROWS - 1 and grid[y + 1][x] == 'wall':  # Lower neighbor
        neighbors.append((x, y + 1))

    return neighbors

def carve_passages_from(grid, cell):
    """Carves passages from a given cell using the algorithm."""
    stack = [cell]
    while stack:
        current_cell = stack[-1]
        grid[current_cell[1]][current_cell[0]] = 'path'  # Mark as visited
        neighbors = get_neighbors(grid, current_cell)

        if not neighbors:
            stack.pop()  # Backtrack
        else:
            random.shuffle(neighbors)  # Randomize the order of neighbors
            next_cell = neighbors[0]
            remove_wall(grid, current_cell, next_cell)
            stack.append(next_cell)

def draw_grid_with_maze():
    """Draws grid lines and the generated maze on the screen."""
    for y in range(GRID_ROWS):
        for x in range(GRID_COLS):
            rect = pygame.Rect(x * CELL_SIZE, y * CELL_SIZE, CELL_SIZE, CELL_SIZE)
            if maze[y][x] == 'wall':
                pygame.draw.rect(screen, BLACK, rect)
            else:
                pygame.draw.rect(screen, GREEN, rect)

def main():
    """Main function to run the maze generator."""
    running = True
    global maze  # Declare global variable for maze
    maze = init_grid()
    start_cell = (0, 0)  # Start from top-left cell
    carve_passages_from(maze, start_cell)
    
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False

        screen.fill(BLACK)
        draw_grid_with_maze()
        
        pygame.display.flip()
        pygame.time.Clock().tick(30)

    pygame.quit()

if __name__ == "__main__":
    main()
import sys

# Constants for window size and grid dimensions
GRID_ROWS = WINDOW_HEIGHT // CELL_SIZE
GRID_COLS = WINDOW_WIDTH // CELL_SIZE

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
GREEN = (0, 255, 0)

>>>>>>> maze_generation_implementation
def init_grid():
    """Initializes the grid with walls and sets all cells as unvisited."""
    grid = [['wall' for _ in range(GRID_COLS)] for _ in range(GRID_ROWS)]
    return grid

def remove_wall(grid, current_cell, next_cell):
    """Removes wall between two adjacent cells."""
    cx, cy = current_cell
    nx, ny = next_cell

    if cx == nx:
        # Horizontal movement
        wall_x = (cx + nx) // 2
        wall_y = cy
        grid[wall_y][wall_x] = 'path'
    elif cy == ny:
        # Vertical movement
        wall_x = cx
        wall_y = (cy + ny) // 2
        grid[wall_y][wall_x] = 'path'

def get_neighbors(grid, cell):
    """Returns list of unvisited neighbors for a given cell."""
    x, y = cell
    neighbors = []
    if x > 0 and grid[y][x - 1] == 'wall':  # Left neighbor
        neighbors.append((x - 1, y))
    if x < GRID_COLS - 1 and grid[y][x + 1] == 'wall':  # Right neighbor
        neighbors.append((x + 1, y))
    if y > 0 and grid[y - 1][x] == 'wall':  # Upper neighbor
        neighbors.append((x, y - 1))
    if y < GRID_ROWS - 1 and grid[y + 1][x] == 'wall':  # Lower neighbor
        neighbors.append((x, y + 1))

    return neighbors

def carve_passages_from(grid, cell):
    """Carves passages from a given cell using the algorithm."""
    stack = [cell]
    while stack:
        current_cell = stack[-1]
        grid[current_cell[1]][current_cell[0]] = 'path'  # Mark as visited
        neighbors = get_neighbors(grid, current_cell)

        if not neighbors:
            stack.pop()  # Backtrack
        else:
            random.shuffle(neighbors)  # Randomize the order of neighbors
            next_cell = neighbors[0]
            remove_wall(grid, current_cell, next_cell)
            stack.append(next_cell)

def draw_grid_with_maze():
    """Draws grid lines and the generated maze on the screen."""
    for y in range(GRID_ROWS):
        for x in range(GRID_COLS):
            rect = pygame.Rect(x * CELL_SIZE, y * CELL_SIZE, CELL_SIZE, CELL_SIZE)
            if maze[y][x] == 'wall':
                pygame.draw.rect(screen, BLACK, rect)
            else:
                pygame.draw.rect(screen, GREEN, rect)

def main():
    """Main function to run the maze generator."""
    running = True
    global maze  # Declare global variable for maze
    maze = init_grid()
    start_cell = (0, 0)  # Start from top-left cell
    carve_passages_from(maze, start_cell)
    
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False

        screen.fill(BLACK)
        draw_grid_with_maze()
        
        pygame.display.flip()
        pygame.time.Clock().tick(30)

    pygame.quit()

if __name__ == "__main__":
    main()
import pygame
import random

# Initialize Pygame
pygame.init()

# Constants for window size and grid dimensions
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600
GRID_SIZE = 20
CELL_SIZE = 30

# Colors
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)

# Setup the display
screen = pygame.display.set_mode((WINDOW_WIDTH, WINDOW_HEIGHT))
pygame.display.set_caption("Maze Generator")

def draw_grid():
    """Draws grid lines on the screen."""
    for x in range(0, WINDOW_WIDTH, CELL_SIZE):
        for y in range(0, WINDOW_HEIGHT, CELL_SIZE):
            rect = pygame.Rect(x, y, CELL_SIZE, CELL_SIZE)
            pygame.draw.rect(screen, WHITE, rect, 1)

def main():
    """Main function to run the maze generator."""
    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False

        screen.fill(BLACK)
        draw_grid()
        
        # Update display and maintain a frame rate of 30 FPS
        pygame.display.flip()
        pygame.time.Clock().tick(30)

    pygame.quit()

if __name__ == "__main__":
    main()
