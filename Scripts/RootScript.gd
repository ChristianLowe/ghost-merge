extends Node2D

signal lever_pulled

onready var player = load("res://Actors/Player.tscn")
onready var ghost_trail = load("res://Actors/GhostTrail.tscn")

onready var unmerge_button = load("res://UI/UnmergeButton.tscn")
onready var interact_button = load("res://UI/InteractButton.tscn")

export (String, FILE, '*tscn') var next_scene_path

var interacting_object = null

var player_position = null

var unmerge_button_instance = null
var interact_button_instance = null

func merge_player(player, interactable):
	interacting_object = interactable
	interacting_object.set_process_input(true)
	
	unmerge_button_instance = unmerge_button.instance()
	add_child(unmerge_button_instance)
	
	interact_button_instance = interact_button.instance()
	add_child(interact_button_instance)
	
	player_position = player.global_position
	player.queue_free()
	
	var ghost_trail_instance = ghost_trail.instance()
	ghost_trail_instance.global_position = player_position
	ghost_trail_instance.target_point = interactable.global_position
	add_child(ghost_trail_instance)

func show_player():
	if interacting_object != null:
		var player_instance = player.instance()
		player_instance.global_position = player_position
		add_child(player_instance)
		player_instance.get_node('KinematicBody2D').play_merge_back_animation(player_position)
		
		interacting_object.set_process_input(false)
		
		unmerge_button_instance.queue_free()
		
		player_position = null
		interacting_object = null

func change_scene():	
	get_tree().change_scene(next_scene_path)


