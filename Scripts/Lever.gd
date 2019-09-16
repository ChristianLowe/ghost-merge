extends KinematicBody2D

onready var root = get_parent().get_parent()

func _ready():
	pass

func interact():
	$AnimationPlayer.play('PullLever')

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'PullLever':
		root.get_node('Door').open_door()