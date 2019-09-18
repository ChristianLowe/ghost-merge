extends Node2D

var target_point = null
var speed = 300

func _process(delta):
	if target_point != null:
		var vector = (target_point - global_position).normalized()
		var velocity = vector * speed
		global_position += velocity * delta
		
		if (target_point - global_position).length() < 5:
			queue_free()
