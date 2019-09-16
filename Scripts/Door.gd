extends Node2D

var open = false

func _ready():
	close_door()

func open_door():
	open = true
	$Sprite.modulate = Color.green

func close_door():
	open = false
	$Sprite.modulate = Color.red
