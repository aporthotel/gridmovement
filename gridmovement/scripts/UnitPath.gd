## Path visualization using TileMapLayer
## Compatible with Godot 4.4.1
class_name UnitPath
extends TileMapLayer

@export var grid: Grid

var _pathfinder: PathFinder
var current_path := PackedVector2Array()

func initialize(walkable_cells: Array) -> void:
	if not grid:
		print("UnitPath: Grid is null!")
		return
	_pathfinder = PathFinder.new(grid, walkable_cells)
	
#OLD DRAW PATH (SNAKE LONG ARROW)
#func draw_path(cell_start: Vector2i, cell_end: Vector2i) -> void:
	#clear()
	#if not _pathfinder:
		#return
	#
	#current_path = _pathfinder.calculate_point_path(cell_start, cell_end)

#NEW DRAW PATH (ONLY ARROW)
func draw_path(cell_start: Vector2i, cell_end: Vector2i) -> void:
	clear()
	if not _pathfinder:
		return
	
	current_path = _pathfinder.calculate_point_path(cell_start, cell_end)
	print("Path found: ", current_path)
	
	for cell in current_path:
		set_cell(Vector2i(cell), 0, Vector2i.ZERO)
#
	for cell in current_path:
		set_cell(Vector2i(cell), 0, Vector2i.ZERO)

func stop() -> void:
	_pathfinder = null
	clear()
