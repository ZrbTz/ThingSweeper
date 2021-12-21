extends Node2D

enum BlockState {COVERED, PRESSED, FLAGGED}
var state = BlockState.COVERED

# Called when the node enters the scene tree for the first time.
func _ready():
	$Bomb.hide()
	$Flag.hide()
	pass # Replace with function body.

func _on_Control_gui_input(event):
	match(state):
		BlockState.COVERED:
			if event.is_action_pressed("left_click"):
				$Cover.hide()
				state = BlockState.PRESSED
			if event.is_action_pressed("right_click"):
				$Flag.show()
				state = BlockState.FLAGGED
		BlockState.FLAGGED:
			if event.is_action_pressed("right_click"):
				$Flag.hide()
				state = BlockState.COVERED

