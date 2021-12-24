extends Node2D

enum BlockState {COVERED, PRESSED, FLAGGED}
var state = BlockState.COVERED
var sprite_size = 256
var has_bomb: bool = false
var bomb_counter = 0
var coordinates: Vector2
var neighbours: Array
#signal got_bomb

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(get_parent().name == "Grid", true)
	$Bomb.hide()
	$Flag.hide()

func _on_Control_gui_input(event):
	match(state):
		BlockState.COVERED:
			if event.is_action_pressed("left_click"):
				state = BlockState.PRESSED
				$Cover.hide()
				if has_bomb:
					$Bomb.show()
#					GameManager.lose()
					get_parent().bombed()
				else:
					uncover()
			if event.is_action_pressed("right_click"):
				$Flag.show()
				state = BlockState.FLAGGED
		BlockState.FLAGGED:
			if event.is_action_pressed("right_click"):
				$Flag.hide()
				state = BlockState.COVERED
				
func uncover_all():
	for n in neighbours:
		if n.state == BlockState.COVERED:
			if not n.has_bomb:
				n.uncover()
			
func uncover():
	state = BlockState.PRESSED
	$Cover.hide()
	if(bomb_counter > 0):
		$Label.text = str(bomb_counter)
	elif bomb_counter == 0: 
		uncover_all()

