extends Node2D

signal lever_pulled

onready var player = load("res://Actors/Player.tscn")
onready var ghost_trail = load("res://Actors/GhostTrail.tscn")

onready var unmerge_button = load("res://UI/UnmergeButton.tscn")
onready var interact_button = load("res://UI/InteractButton.tscn")
onready var hat_cane = load("res://Actors/HatCane.tscn")
onready var merge_orb = load("res://Actors/MergeOrb.tscn")
onready var hat_cane_left_texture = load("res://Sprites/Ghost/hat-cane-left.png")
onready var hat_cane_texture = load("res://Sprites/Ghost/hat-cane.png")

export var merge_count: int = 2

export (String, FILE, '*tscn') var next_scene_path

var interacting_object = null

var player_position = null

var unmerge_button_instance = null
var interact_button_instance = null
var hat_cane_instance = null
var merge_orb_instance = null
var user_direction = null
var modulate_default = 'ffffff'
var modulate_active = 'ffc80a'
var showing_player = true

func _ready():
	$CanvasLayer/MergeCountLabel.update_merge_count(merge_count)
	
	SignalBus.connect('interact', self, '_interact')
	SignalBus.connect('unmerge', self, '_unmerge')

func merge_player(player, interactable):
	SoundController.play_effect("res://Sounds/merge.wav", -40)
	interacting_object = interactable
	interacting_object.set_process_input(true)
	interactable.set_modulate_color(modulate_active)
	if interacting_object.get_node('Sprite').is_class('AnimatedSprite'):
		interacting_object.get_node('Sprite').playing = true
	#unmerge_button_instance = unmerge_button.instance()
	#add_child(unmerge_button_instance)
	
	#interact_button_instance = interact_button.instance()
	#add_child(interact_button_instance)
	
	player_position = player.global_position
	
	hat_cane_instance = hat_cane.instance()
	hat_cane_instance.global_position = player_position
	user_direction = player.get("direction")
	
	var player_direction = player.get_node("Sprite").animation
	if(player_direction == "back_left" or player_direction == "front"
	   or player_direction == "front_right" or player_direction ==  "left"):
		hat_cane_instance.get_node('KinematicBody2D').get_node("Sprite").set_texture(hat_cane_left_texture)
	else:
		hat_cane_instance.get_node('KinematicBody2D').get_node("Sprite").set_texture(hat_cane_texture)
	
	merge_orb_instance = merge_orb.instance()
	merge_orb_instance.global_position = player_position
	player.queue_free()
	
	var ghost_trail_instance = ghost_trail.instance()
	ghost_trail_instance.global_position = player_position
	ghost_trail_instance.target_point = interactable.global_position
	add_child(ghost_trail_instance)
	
	merge_count -= 1
	
	$CanvasLayer/MergeCountLabel.update_merge_count(merge_count)

	showing_player = false

func show_player():
	if interacting_object != null:
		showing_player = true
		SoundController.play_effect("res://Sounds/Merge.wav", -40)
		var player_instance = player.instance()
		
		# There is a slight northern increase. this is a janky but accurate fix
		player_position = Vector2(player_position.x, player_position.y + 20)
		
		player_instance.global_position = player_position
		
		var interactable = interacting_object
		
		interactable.set_modulate_color(modulate_default)
		
		var ghost_trail_instance = ghost_trail.instance()
		ghost_trail_instance.global_position = interactable.global_position
		ghost_trail_instance.target_point = player_position
		
		add_child(ghost_trail_instance)		
		interacting_object.set_process_input(false)
		yield(ghost_trail_instance, "trail_arrived")
		
		add_child(player_instance)
		player_instance.get_node('KinematicBody2D').play_merge_back_animation(player_position, user_direction)
		
		if interacting_object.get_node('Sprite').is_class('AnimatedSprite'):
			interacting_object.get_node('Sprite').playing = false
		#unmerge_button_instance.queue_free()
		
		player_position = null
		interacting_object = null
		
		showing_player = false

func can_player_merge():
	return merge_count > 0

func change_scene():	
	get_tree().change_scene(next_scene_path)

func _interact():
	if interacting_object != null and interacting_object.has_method('interact'):
		interacting_object.interact()

func _unmerge():
	if not showing_player:
		show_player()
