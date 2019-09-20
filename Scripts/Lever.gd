extends KinematicBody2D

onready var root = get_parent().get_parent()
onready var state = "left"

export var use_time_limit: bool = false
export var time_limit: int = 10

func _ready():
	state = "left"
	
	if use_time_limit:
		$Timer.wait_time = time_limit
		$Timer.connect('timeout', self, 'pull_lever_left')

func pull_lever_right():
	SoundController.play_effect("res://Sounds/Lever.wav", -10)
	$AnimationPlayer.play('PullLever')
	state = "right"
	
	if use_time_limit:
		$Timer.start()

func pull_lever_left():
	SoundController.play_effect("res://Sounds/Lever.wav", -10)
	$AnimationPlayer.play('PullLeverReverse')
	state = "left"
	
	if use_time_limit:
		$Timer.stop()

func interact():
	if state == "left":
		pull_lever_right()
			
	elif state == "right":
		pull_lever_left()
		

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'PullLever':
		root.get_node('Door').open_door()
	if anim_name == 'PullLeverReverse':
		root.get_node('Door').close_door()
		
func set_modulate_color(color):
	$Sprite.set("modulate", color)