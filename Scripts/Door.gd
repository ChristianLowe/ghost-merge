extends Node2D

onready var root = get_parent()
var open = false

func _ready():
	close_door()

func open_door():
	open = true
	$Sprite.modulate = Color.green

func close_door():
	open = false
	$Sprite.modulate = Color.red

func _on_Area2D_body_entered(body):
	if not open:
		return
		
	if 'Player' in body.get_parent().get_name():
		root.change_scene()
