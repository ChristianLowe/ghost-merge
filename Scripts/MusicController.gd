extends Node

onready var _effects_player = $SoundEffectPlayer
onready var _bg_player = $BGPlayer

func play_bg():
	_bg_player.play()
	
func stop_bg():
	_bg_player.stop()
	
func play_effect(track_url : String):
    var track = load(track_url)
    _effects_player.stream = track
    _effects_player.play()

# Calling this function will stop the music
func stop_effect():
    _effects_player.stop()