extends Node

onready var _effects_player = $SoundEffectPlayer
onready var _bg_player = $BGPlayer
onready var default = -20

func play_bg(track_url, volume):
	var track = load(track_url)
	if not volume:
		volume = -20
	_bg_player.volume_db = volume
	_bg_player.stream = track
	_bg_player.play()
	
func stop_bg():
	_bg_player.stop()
	
func play_effect(track_url : String, volume):
	var track = load(track_url)
	if not volume:
		volume = -20
	_effects_player.volume_db = volume
	_effects_player.stream = track
	_effects_player.play()

# Calling this function will stop the music
func stop_effect():
    _effects_player.stop()