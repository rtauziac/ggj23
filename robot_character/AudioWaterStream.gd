extends Node2D

export (float) var sounds_delay = 0.2
var _play_sounds_in_sequence = false
var _sound_cooldown = 0.0
var _player_index = 0
var _sound_index = 0
var _water_sounds: Array = [
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_1_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_2_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_3_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_4_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_5_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_6_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_7_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_8_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_9_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_10_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_11_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_Long_1_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_Long_2_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_Long_3_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_Long_4_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_Long_5_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_Long_6_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_Long_7_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_Long_8_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_Long_9_V1.wav"),
	preload("res://assets/sounds/GPE/SFX_OS_GPE_Water_SplashGround_Long_10_V1.wav")
]


func _on_water_leak_state_change(state):
	_play_sounds_in_sequence = state
	if _sound_cooldown <= 0:
		_sound_cooldown = sounds_delay


func _process(delta):
	if _sound_cooldown > 0:
		_sound_cooldown -= delta
		if _play_sounds_in_sequence and _sound_cooldown <= 0:
			var _audio_player = get_node("WaterStreamPlayer%d" % _player_index) as AudioStreamPlayer2D
			_sound_index = (_sound_index + 1) % _water_sounds.size()
			_player_index = (_player_index + 1) % get_child_count()
			_audio_player.stop()
			_audio_player.stream = _water_sounds[_sound_index]
			_audio_player.play()
			
