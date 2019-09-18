extends KinematicBody2D

onready var root = get_parent().get_parent()
onready var state = "left"

func _ready():
	state = "left"
	pass

func interact():
	print(state)
	if state == "left":
		$AnimationPlayer.play('PullLever')
		state = "right"
	elif state == "right":
		$AnimationPlayer.play('PullLeverReverse')
		state = "left"
		

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'PullLever':
		root.get_node('Door').open_door()
	if anim_name == 'PullLeverReverse':
		root.get_node('Door').close_door()