extends Node2D

func open():
	print('the gate... is opened.')
#	$StaticBody2D/CollisionShape2D.queue_free()
	$StaticBody2D/CollisionShape2D.set_deferred('disabled', true)
	
func close():
	print('the gate... is closed.')
	$StaticBody2D/CollisionShape2D.set_deferred('disabled', false)