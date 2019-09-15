extends Area2D

onready var parent = get_parent()
onready var interactable = get_parent().get_parent()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		interactable.emit_signal('clicked', parent)
