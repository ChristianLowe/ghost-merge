extends KinematicBody2D

export var speed: int = 200

onready var target = Vector2(global_position.x, global_position.y)
onready var root = get_parent().get_parent()

var velocity = Vector2.ZERO
var merged: Node2D = null

func _ready():
	root.get_node('Interactable').connect('clicked', self, 'attempt_merge')
	

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		target = get_global_mouse_position()
		
func get_direction(angle):	
	if angle > 1.125 and angle < 1.875:
		return 'front'
	elif angle > 1.875 and angle < 2.625:
		return 'front_left'
	elif (angle > 2.625 and angle < PI) or (angle > -PI and angle < -2.625):
		return 'left'
	elif angle > -2.625 and angle < -1.875:
		return 'back_left'
	elif angle > -1.875 and angle < -1.125:
		return 'back'
	elif angle > -1.125 and angle < -0.375:
		return 'back_right'
	elif angle > -0.375 and angle < 0.375:
		return 'right'
	elif angle > 0.375 and angle < 1.125:
		return 'front_right'
		
	return 'default'

func _physics_process(delta):
	velocity = (target - global_position).normalized() * speed
		
	var angle = velocity.angle()
	var direction = get_direction(angle)
	if direction != null:
		$Sprite.animation = direction
		
	if (target - global_position).length() > 5:
		velocity = move_and_slide(velocity)

func attempt_merge(interactable):
	if interactable in $InteractableArea.in_range:
		root.merge_player(self, interactable)
