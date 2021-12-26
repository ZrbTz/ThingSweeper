extends Node
onready var Grid
onready var Player

var active_tiles: Array

var player_scene = preload("res://Player/Player.tscn")

func _ready():
	Grid = get_node("/root/Grid")
	set_grid(Grid)
	spawn_player(Vector2.ZERO)

func spawn_player(spawn_pos: Vector2):
	Player = player_scene.instance()
	Player.connect("player_moved", self, "_on_player_moved")
	Player.position = spawn_pos
	Grid.add_child(Player)

func _on_player_moved(pos):
	var new_active_tiles = Grid.tiles[pos].neighbours
	if active_tiles.size() > 0:
		for t in active_tiles:
			t.disable_highlight()
	for t in new_active_tiles:
		t.highlight()
	active_tiles = new_active_tiles

func set_grid(grid_node: Node):
	var err = grid_node.connect("got_bomb", self, "lose")
	if err:
		print(err)
		
func lose():
	get_tree().paused = true
	print("You lost")
