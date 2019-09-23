extends ColorRect

func flash():
	modulate.a = 0.8
	
func _process(delta):
	if modulate.a > 0:
		modulate.a -= .8 * delta
	
	if modulate.a < 0:
		modulate.a = 0
