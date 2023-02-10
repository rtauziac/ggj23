extends AudioStreamPlayer2D

export (Array) var sounds: Array = []
var _sound_index = 0


func play_random():
	stream = sounds[_sound_index]
	play()
	_sound_index = (_sound_index + 1) % sounds.size()
