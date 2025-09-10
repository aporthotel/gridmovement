@tool
## Grid resource for tactical RPG movement system
## Compatible with Godot 4.4.1
class_name Grid
extends Resource

@export var size := Vector2i(20, 20)
@export var cell_size := Vector2i(80, 80)

var _half_cell_size: Vector2i

func _init():
	_half_cell_size = cell_size / 2

func calculate_map_position(grid_position: Vector2i) -> Vector2:
	return Vector2(grid_position * cell_size + _half_cell_size)

func calculate_grid_coordinates(map_position: Vector2) -> Vector2i:
	return Vector2i(map_position / Vector2(cell_size))

func is_within_bounds(cell_coordinates: Vector2i) -> bool:
	return (cell_coordinates.x >= 0 and cell_coordinates.x < size.x and 
			cell_coordinates.y >= 0 and cell_coordinates.y < size.y)

func grid_clamp(grid_position: Vector2i) -> Vector2i:
	var out := grid_position
	out.x = clamp(out.x, 0, size.x - 1)
	out.y = clamp(out.y, 0, size.y - 1)
	return out

func as_index(cell: Vector2i) -> int:
	return cell.x + size.x * cell.y
