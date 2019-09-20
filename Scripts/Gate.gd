extends Node2D

func open():
	SoundController.play_effect("res://Sounds/Door.wav", -40)
	print('the gate... is opened.')
	$StaticBody2D/CollisionShape2D.queue_free()