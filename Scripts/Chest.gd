extends KinematicBody2D

export var sound_url: String = ""

onready var root = get_parent().get_parent()

func _ready():
	pass

func interact():
	open()
	close()

func set_modulate_color(color):
	$Sprite.set("modulate", color)
	
func close():
	get_parent().get_node(get("name")).get_node("AnimationPlayer").play("Open")
	get_parent().get_node(get("name")).get_node("AnimationPlayer").play("Close")

func open():
	$AnimationPlayer.play("Open")
	SoundController.play_bg(sound_url, -20)