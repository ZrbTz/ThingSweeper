extends Node2D

export var height: int 
export var width: int 
var block_scene = preload("res://Grid/GridBlock/GridBlock.tscn")
export var max_bombs: int
var tiles = {}
signal got_bomb

# Called when the node enters the scene tree for the first time.
func _ready():
	draw_grid()
	init_bombs()

func draw_grid():
	for w in range(width):
		for h in range(height):
			var block = block_scene.instance()
			block.position = block.scale*block.sprite_size*Vector2(w, h)
			add_child(block)
			tiles[Vector2(w, h)] = block
			
func init_bombs():
	var bombs = 0
	while bombs < max_bombs:
		randomize()
		var rw = abs(randi() % width)
		randomize()
		var rh = abs(randi() % height)
		var tile = tiles[Vector2(rw, rh)]
		if not tile.has_bomb:
			tile.has_bomb = true
			bombs += 1
			add_neighbours(rw, rh)
			
func add_neighbours(rw, rh):
	for v2 in get_neighbours(rw, rh):
		if(tiles.has(v2)):
			tiles[v2].bomb_counter+=1
	
func get_neighbours(rw, rh):
	return [Vector2(rw-1, rh), Vector2(rw-1, rh-1), Vector2(rw-1, rh+1), Vector2(rw+1, rh),
	Vector2(rw+1, rh+1), Vector2(rw+1, rh-1), Vector2(rw, rh-1), Vector2(rw, rh+1)]

func bombed():
	emit_signal("got_bomb")
