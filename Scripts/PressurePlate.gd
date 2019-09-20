extends Node2D

export (NodePath) var gate_path

func _on_Area2D_body_entered(body):
	if body.get_parent().get_name() == 'Interactable':
		get_node(gate_path).open()

func _on_Area2D_body_exited(body):
	if body.get_parent().get_name() == 'Interactable':
		get_node(gate_path).close()
