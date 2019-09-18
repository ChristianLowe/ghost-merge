extends Node2D

var target_point = null
var speed = 150

func _process(delta):
	if target_point != null:
		var vector = (target_point - global_position).normalized()
		var velocity = vector * speed
		global_position += velocity * delta
		
		if (target_point - global_position).length() < 5:
			$Particles2D.emitting = false
			$Particles2DStream.emitting = false
			set_process(false)
