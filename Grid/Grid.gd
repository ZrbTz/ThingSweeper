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
			block.coordinates = Vector2(w, h)
			add_child(block)
			tiles[Vector2(w, h)] = block
	for b in tiles.values():
		b.neighbours = map_pos_to_tile(get_neighbours(b.coordinates))
			
func init_bombs():
	var bombs = 0
	while bombs < max_bombs:
		randomize()
		var rw = abs(randi() % width)
		randomize()
		var rh = abs(randi() % height)
		var pos = Vector2(rw, rh)
		var tile = tiles[pos]
		if not tile.has_bomb:
			tile.has_bomb = true
			bombs += 1
			add_neighbours(pos)
			
func add_neighbours(pos):
	for v2 in get_neighbours(pos):
		tiles[v2].bomb_counter+=1
	
func get_neighbours(v2):
	var rw = v2.x
	var rh = v2.y
	var list = [Vector2(rw-1, rh), Vector2(rw-1, rh-1), Vector2(rw-1, rh+1), Vector2(rw+1, rh),
	Vector2(rw+1, rh+1), Vector2(rw+1, rh-1), Vector2(rw, rh-1), Vector2(rw, rh+1)]
	var result_list = []
	for v2 in list:
		if(tiles.has(v2)):
			result_list.append(v2)
	return result_list
	
func map_pos_to_tile(pos_list):
	var tile_list = []
	for pos in pos_list:
		tile_list.append(tiles[pos])
	return tile_list
			

func bombed():
	emit_signal("got_bomb")
