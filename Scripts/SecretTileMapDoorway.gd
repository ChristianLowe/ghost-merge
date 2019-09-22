extends TileMap
onready var init = true
onready var sound_played = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if not init:
		if not sound_played:
			SoundController.play_effect("res://Sounds/SuitOfArmorWalk.wav", -20)
			sound_played = true
		get_parent().get_node("SecretTileMap").visible = true
		get_parent().get_node("Interactable/ChestMetal").visible = true
		get_parent().get_node("Interactable/ChestNight").visible = true
		get_parent().get_node("Interactable/ChestVideo").visible = true
		get_parent().get_node("Interactable/ChestWicked").visible = true
		visible = false
	else:
		init = false
