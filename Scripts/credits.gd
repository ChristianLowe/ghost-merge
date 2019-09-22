extends Control

var scene_path_to_load

func _on_FadeIn_fade_finished():
	if scene_path_to_load == 'exit':
		get_tree().quit()
	else:
		get_tree().change_scene(scene_path_to_load)

func _on_LeftButton_pressed():
	var button = $"Tutorial Area/LeftButton"
	scene_path_to_load = button.scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()
