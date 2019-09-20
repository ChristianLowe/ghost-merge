extends Node2D

export (NodePath) var gate_path

onready var interactable_objects: Array = []

func _on_Area2D_body_entered(body):
	if body.get_parent().get_name() == 'Interactable':
		SoundController.play_effect("res://Sounds/PressurePlate.wav", -20)

		interactable_objects.append(body)

		if interactable_objects.size() > 0:
			if gate_path:
				get_node(gate_path).open()
			$Sprite.play('down')

func _on_Area2D_body_exited(body):
	if body.get_parent().get_name() == 'Interactable':
		
		var body_on_plate = interactable_objects.find(body)
		if body_on_plate == null:
			return
			
		interactable_objects.remove(body_on_plate)
		
		if interactable_objects.size() == 0:
			if gate_path:
				get_node(gate_path).close()
			$Sprite.play('up')
			
