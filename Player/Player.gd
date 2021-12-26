extends Node2D

var grid_pos: Vector2
var input_vector: Vector2
var block_size: int = 256
var Grid: Node2D

func _ready():
	Grid = GameManager.Grid
	grid_pos = Vector2.ZERO

func _process(_delta):
	input_vector = get_input_vector()
	handle_movements()

func handle_movements():
	var new_pos = Vector2(
		grid_pos.x + input_vector.x, 
		grid_pos.y +input_vector.y)
	if Grid.can_move_to(new_pos):
		grid_pos = new_pos
		position = new_pos * Grid.block_size * Grid.block_scale

func get_input_vector():
	input_vector.x = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))
	input_vector.y = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))
	return input_vector

