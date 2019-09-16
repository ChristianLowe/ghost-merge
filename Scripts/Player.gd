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

func _physics_process(delta):
	velocity = (target - global_position).normalized() * speed
#	rotation = velocity.angle()
	if (target - global_position).length() > 5:
		velocity = move_and_slide(velocity)

func attempt_merge(interactable):
	if interactable in $InteractableArea.in_range:
		root.merge_player(self, interactable)
