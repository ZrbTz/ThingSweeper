extends Node2D

export var height: int 
export var width: int 
var block = preload("res://Grid/GridBlock/GridBlock.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	block.instance()
	pass # Replace with function body.

