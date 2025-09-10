## Player cursor for grid navigation
## Compatible with Godot 4.4.1
@tool
class_name Cursor
extends Node2D

signal accept_pressed(cell: Vector2i)
signal moved(new_cell: Vector2i)

@export var grid: Grid
@export var ui_cooldown := 0.1

var cell := Vector2i.ZERO:
	set(value):
		if not grid:
			return
		var new_cell := grid.grid_clamp(value)
		if new_cell == cell:
			return
		
		cell = new_cell
		position = grid.calculate_map_position(cell)
		emit_signal("moved", cell)
		_timer.start()

@onready var _timer: Timer = $Timer

func _ready() -> void:
	_timer.wait_time = ui_cooldown
	if grid:
		position = grid.calculate_map_position(cell)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and grid:
		cell = grid.calculate_grid_coordinates(event.position)
	elif event.is_action_pressed("click") or event.is_action_pressed("ui_accept"):
		emit_signal("accept_pressed", cell)
		get_viewport().set_input_as_handled()
	
	var should_move := event.is_pressed()
	if event.is_echo():
		should_move = should_move and _timer.is_stopped()
	
	if not should_move:
		return
	
	if event.is_action("ui_right"):
		cell += Vector2i.RIGHT
	elif event.is_action("ui_up"):
		cell += Vector2i.UP
	elif event.is_action("ui_left"):
		cell += Vector2i.LEFT
	elif event.is_action("ui_down"):
		cell += Vector2i.DOWN

func _draw() -> void:
	if grid:
		draw_rect(Rect2(-Vector2(grid.cell_size) / 2, Vector2(grid.cell_size)), Color.ALICE_BLUE, false, 2.0)


func _on_moved(new_cell: Vector2i) -> void:
	pass # Replace with function body.


func _on_accept_pressed(cell: Vector2i) -> void:
	pass # Replace with function body.
