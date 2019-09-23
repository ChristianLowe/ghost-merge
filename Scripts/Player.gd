extends KinematicBody2D

export var speed: int = 200

onready var direction = ''
onready var target = Vector2(global_position.x, global_position.y)
onready var root = get_parent().get_parent()

var velocity = Vector2.ZERO
var merged: Node2D = null
var interactable: Node2D = null

func _ready():
	root.get_node('Interactable').connect('clicked', self, 'attempt_merge')

func _unhandled_input(event):
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
		return 'front_left'
	elif (angle >= 2.625 and angle <= 3.15) or (angle >= -3.15 and angle <= -2.625):
		return 'left'
	elif angle > -2.625 and angle < -1.875:
		return 'back_left'
	elif angle >= -1.875 and angle < -1.125:
		return 'back'
	elif angle >= -1.125 and angle < -0.375:
		return 'back_right'
	elif angle >= -0.375 and angle < 0.375:
		return 'right'
	elif angle >= 0.375 and angle < 1.125:
		return 'front_right'
		
	return 'default'

func _physics_process(delta):
	velocity = (target - global_position).normalized() * speed
		
	if (target - global_position).length() > 5:
		velocity = move_and_slide(velocity)

func play_merge_animation(target):
	if direction != null:
		$Sprite.stop()
		$Sprite.set_frame(0)
		$Sprite.play(direction + '_merge')
		
func play_merge_back_animation(target, dir):
	direction = dir
	if direction != null:
		$Sprite.stop()
		$Sprite.set_frame(0)
		$Sprite.play(direction + '_remerge')

func attempt_merge(interactable):
	if interactable in $InteractableArea.in_range:
		if root.can_player_merge():
			self.interactable = interactable
			speed = 0
			play_merge_animation(interactable.global_position)
		else:
			SoundController.play_effect("res://Sounds/OutOfMerges.wav", -20)

func _on_Sprite_animation_finished():
	if 'merge' in $Sprite.animation:
		if 'remerge' in $Sprite.animation:
			$Sprite.play(direction)
		else:
			root.merge_player(self, interactable)
