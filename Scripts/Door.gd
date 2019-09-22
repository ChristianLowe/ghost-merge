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
	
	$DoorClosed.visible = not $DoorClosed.visible
	$DoorOpened.visible = not $DoorOpened.visible
	
	$StaticBody2D/CollisionShapeBottom.disabled = not $StaticBody2D/CollisionShapeBottom.disabled
	$StaticBody2D/CollisionShapeTop.disabled = not $StaticBody2D/CollisionShapeTop.disabled
	$StaticBody2D/CollisionShapeOpen.disabled = not $StaticBody2D/CollisionShapeOpen.disabled
