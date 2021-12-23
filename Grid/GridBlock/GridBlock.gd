extends Node2D

enum BlockState {COVERED, PRESSED, FLAGGED}
var state = BlockState.COVERED
var sprite_size = 256
var has_bomb: bool = false
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
				$Cover.hide()
				if has_bomb:
					$Bomb.show()
#					GameManager.lose()
					get_parent().bombed()
				state = BlockState.PRESSED
			if event.is_action_pressed("right_click"):
				$Flag.show()
				state = BlockState.FLAGGED
		BlockState.FLAGGED:
			if event.is_action_pressed("right_click"):
				$Flag.hide()
				state = BlockState.COVERED

