extends Node2D

func open():
	print('the gate... is opened.')
	$StaticBody2D/CollisionShape2D.queue_free()