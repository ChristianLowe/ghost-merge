extends KinematicBody2D

onready var root = get_parent().get_parent()

func _ready():
	pass

func interact():
	root.get_node('Door').open_door()
