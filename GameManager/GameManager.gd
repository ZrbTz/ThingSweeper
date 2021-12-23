extends Node
var Grid

func _ready():
	set_grid(get_node("/root/Grid"))


func set_grid(grid_node: Node):
	Grid = grid_node
	Grid.connect("got_bomb", self, "lose")

func lose():
	get_tree().paused = true
	print("You lost")
