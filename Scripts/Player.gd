extends KinematicBody2D

export var speed: int = 100

var target = Vector2()
var velocity = Vector2()

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = (target - global_position).normalized() * speed
	rotation = velocity.angle()
	if (target - global_position).length() > 5:
		velocity = move_and_slide(velocity)
