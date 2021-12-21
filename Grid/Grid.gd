extends Node2D

export var height: int 
export var width: int 
var block_scene = preload("res://Grid/GridBlock/GridBlock.tscn")
export var max_bombs: int
var tiles

# Called when the node enters the scene tree for the first time.
func _ready():
	draw_grid()
	init_bombs()

func draw_grid():
	for i in range(height):
		for n in range(width):
			var block = block_scene.instance()
			block.position = block.scale*block.sprite_size*Vector2(i, n)
			add_child(block)
	tiles = get_children()
			
func init_bombs():
	var bombs = 0
	while bombs < max_bombs:
		var tile = tiles[randi() % len(tiles)]
		if not tile.has_bomb:
			tile.has_bomb = true
			bombs += 1

