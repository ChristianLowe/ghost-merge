extends Node2D

export (NodePath) var gate_path

func _on_Area2D_body_entered(body):
	if body.get_parent().get_name() == 'Interactable':
		SoundController.play_effect("res://Sounds/PressurePlate.wav", -20)
		get_node(gate_path).open()
