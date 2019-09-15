extends KinematicBody2D

export var speed: int = 100

onready var target = Vector2(global_position.x, global_position.y)
onready var velocity = Vector2.ZERO

onready var root = get_parent().get_parent()

func _ready():
	root.get_node('Interactable').connect('clicked', self, 'attempt_merge')

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = (target - global_position).normalized() * speed
	rotation = velocity.angle()
	if (target - global_position).length() > 5:
		velocity = move_and_slide(velocity)

func attempt_merge(interactable):
	if interactable in $InteractableArea.in_range:
		print("Reason number two. Look what I can do.")
