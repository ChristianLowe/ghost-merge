extends Node2D

onready var root = get_parent()
var open = false 

func _ready():
	close_door(true)

func open_door():
	SoundController.play_effect("res://Sounds/Door.wav", -20)
	_flip_door()

func close_door(init=false):
	if not init:
		SoundController.play_effect("res://Sounds/Door.wav", -20)
		_flip_door()
	else:
		open = false

func _on_Area2D_body_entered(body):
	if not open:
		return
		
	if 'Player' in body.get_parent().get_name():
		root.change_scene()
		
func _flip_door():
	open = not open
	$VerticalDoor.visible = not $VerticalDoor.visible
	$StaticBody2D/CollisionShapeVerticalDoor.visible = not $StaticBody2D/CollisionShapeVerticalDoor.visible
	
	$HorizontalDoor.visible = not $HorizontalDoor.visible
	$Area2D/CollisionShapeHorizontalDoor.visible = not $Area2D/CollisionShapeHorizontalDoor.visible
	$StaticBody2D/CollisionShapeHorizontalDoor.visible = not $StaticBody2D/CollisionShapeHorizontalDoor.visible

	
