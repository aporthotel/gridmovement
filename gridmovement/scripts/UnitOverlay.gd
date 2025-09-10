## Overlay for showing walkable cells
## Uses TileMapLayer (Godot 4.4.1)
class_name UnitOverlay
extends TileMapLayer

func draw_cells(cells: Array) -> void:
	clear()
	for cell in cells:
		set_cell(Vector2i(cell), 0, Vector2i.ZERO)
