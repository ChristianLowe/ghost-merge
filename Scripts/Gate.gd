extends Node2D

onready var is_open: bool = false

func _ready():
	$Sprite2.frame = 0

func open():
	if is_open:
		return
		
	SoundController.play_effect("res://Sounds/Door.wav", -40)
	print('the gate... is opened.')
	$StaticBody2D/CollisionShape2D.set_deferred('disabled', true)
	$Sprite2/AnimationPlayer.play('open')
	is_open = true
	
func close():
	if not is_open:
		return
		
	print('the gate... is closed.')
	$StaticBody2D/CollisionShape2D.set_deferred('disabled', false)
	$Sprite2/AnimationPlayer.play('close')
	is_open = false