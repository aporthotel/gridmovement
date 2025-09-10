## AStar pathfinding for tactical RPG
## Compatible with Godot 4.4.1
class_name PathFinder
extends Resource

const DIRECTIONS = [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]

var _grid: Grid
var _astar := AStarGrid2D.new()

func _init(grid: Grid, walkable_cells: Array) -> void:
	_grid = grid
	_astar.region = Rect2i(Vector2i.ZERO, _grid.size)
	_astar.cell_size = Vector2(_grid.cell_size)
	_astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	_astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	_astar.update()
	
	# Disable non-walkable cells
	for y in _grid.size.y:
		for x in _grid.size.x:
			if not walkable_cells.has(Vector2i(x, y)):
				_astar.set_point_solid(Vector2i(x, y))

func calculate_point_path(start: Vector2i, end: Vector2i) -> PackedVector2Array:
	return _astar.get_id_path(start, end)
