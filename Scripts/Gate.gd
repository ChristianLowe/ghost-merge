extends Node2D

onready var is_open: bool = false
onready var sprite = $HorizontalGate
export var is_vertical: bool = false

func _ready():
	if is_vertical:
		sprite = $VerticleGate
		$VerticleGate.visible = true
		$HorizontalGate.visible = false
	sprite.frame = 0

func open():
	if is_open:
		return
	
	SoundController.play_effect("res://Sounds/Door.wav", -40)
	print('the gate... is opened.')
	$StaticBody2D/CollisionShape2D.set_deferred('disabled', true)
	sprite.get_node("AnimationPlayer").play('open')
	is_open = true
	
func close():
	if not is_open:
		return
		
	print('the gate... is closed.')
	$StaticBody2D/CollisionShape2D.set_deferred('disabled', false)
	sprite.get_node("AnimationPlayer").play('close')
	is_open = false