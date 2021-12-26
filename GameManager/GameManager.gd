extends Node
onready var Grid
onready var Player
var player_scene = preload("res://Player/Player.tscn")

func _ready():
	Grid = get_node("/root/Grid")
	set_grid(Grid)
	spawn_player(Vector2.ZERO)

func spawn_player(spawn_pos: Vector2):
	Player = player_scene.instance()
	Player.position = spawn_pos
	Grid.add_child(Player)

func set_grid(grid_node: Node):
	var err = grid_node.connect("got_bomb", self, "lose")
	if err:
		print(err)
		
func lose():
	get_tree().paused = true
	print("You lost")
