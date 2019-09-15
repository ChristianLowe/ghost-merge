extends Node2D

func _ready():
	var parent_sprite = get_parent().get_node('Sprite')
	var sprite = get_node('Sprite')

	sprite.texture = parent_sprite.texture
	sprite.global_position = parent_sprite.global_position

	sprite.centered = true
	parent_sprite.centered = true

	sprite.scale = parent_sprite.scale + Vector2(0.5, 0.5)
	sprite.modulate = Color(1, 0, 0, 0.5)
	
	show_behind_parent = true
	