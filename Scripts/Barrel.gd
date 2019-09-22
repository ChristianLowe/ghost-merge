extends KinematicBody2D

onready var velocity = Vector2(0,0)
onready var direction = ''
onready var target
export var speed: int = 200

func _ready():
	set_process_unhandled_input(false)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if velocity != Vector2(0,0):
			return
			
		target = get_global_mouse_position()

		direction = get_direction(target)
		if direction == 'front':
			velocity = Vector2(0,1) * speed
			rotation = 0
			$Sprite.play('Roll', true)
		elif direction == 'back':
			velocity = Vector2(0,-1) * speed
			rotation = 0
			$Sprite.play('Roll')
		elif direction == 'left':
			velocity = Vector2(-1,0) * speed
			$Sprite.play('Roll', true)
			rotation = deg2rad(90)
		elif direction == 'right':
			velocity = Vector2(1,0) * speed
			rotation = deg2rad(90)
			$Sprite.play('Roll')
#		if direction != null:
#			$Sprite.animation = direction

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
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = Vector2(0,0)
		$Sprite.playing = false

func set_modulate_color(color):
	$Sprite.set("modulate", color)