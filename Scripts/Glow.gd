extends Node2D

func _ready():
	var parent_sprite = get_parent().get_node('Sprite')
	var sprite = get_node('Sprite')

	if parent_sprite.is_class('Sprite'):
		sprite.texture = parent_sprite.texture
		sprite.vframes = parent_sprite.vframes
		sprite.hframes = parent_sprite.hframes
		sprite.frame = parent_sprite.frame
	elif parent_sprite.is_class('AnimatedSprite'):
		var parent_frame = parent_sprite.get_frame()
		var parent_animation = parent_sprite.get_animation()
		sprite.texture = parent_sprite.get_sprite_frames().get_frame(parent_animation, parent_frame)

	sprite.global_position = parent_sprite.global_position
	sprite.centered = true
	parent_sprite.centered = true

	sprite.scale = parent_sprite.scale + Vector2(0.5, 0.5)
	sprite.modulate = Color(1, 0, 0, 0.5)
	
	show_behind_parent = true
	