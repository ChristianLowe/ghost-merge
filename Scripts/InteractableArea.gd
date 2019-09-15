extends Area2D

var glow: Resource

var in_range: Array

func _ready():
	glow = load("res://Actors/Glow.tscn")
	connect('body_entered', self, '_on_body_entered')
	connect('body_exited', self, '_on_body_exited')

func _on_body_entered(body):
	if body.get_parent().name == 'Interactable':
		in_range.append(body)
		
		var glow_instance = glow.instance()
		glow_instance.name = 'Glow'
		body.add_child(glow_instance)

func _on_body_exited(body):
	if body.get_parent().name == 'Interactable':
		in_range.erase(body)
				
		var glow_instance = body.get_node('Glow')
		body.remove_child(glow_instance)
