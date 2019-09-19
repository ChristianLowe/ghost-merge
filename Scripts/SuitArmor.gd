extends KinematicBody2D

onready var target = global_position
onready var velocity = Vector2(0,0)
onready var direction = ''

export var speed: int = 100

func _ready():
	set_process_input(false)
	$Sprite.playing = false

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		target = get_global_mouse_position()

		direction = get_direction(target)
		if direction != null:
			$Sprite.animation = direction

func get_direction(target):	
	var angle = ((target - global_position).normalized() * speed).angle()

	if angle >= 1.125 and angle < 1.875:
		return 'front'
	elif angle >= 1.875 and angle < 2.625:
		return 'front'
	elif (angle >= 2.625 and angle <= 3.15) or (angle >= -3.15 and angle <= -2.625):
		return 'left'
	elif angle > -2.625 and angle < -1.875:
		return 'left'
	elif angle >= -1.875 and angle < -1.125:
		return 'back'
	elif angle >= -1.125 and angle < -0.375:
		return 'back'
	elif angle >= -0.375 and angle < 0.375:
		return 'right'
	elif angle >= 0.375 and angle < 1.125:
		return 'right'
		
	return 'default'
	
func _physics_process(delta):
	velocity = (target - global_position).normalized() * speed
		
	if (target - global_position).length() > 5:
		velocity = move_and_slide(velocity)
		
func interact():
	print(get_name() + ' interacting...')
