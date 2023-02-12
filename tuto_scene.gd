extends Control


func _process(_delta: float) -> void:
	if Input.is_physical_key_pressed(KEY_ENTER) or Input.is_joy_button_pressed(0, JOY_START) or Input.is_joy_button_pressed(1, JOY_START) or Input.is_joy_button_pressed(2, JOY_START) or Input.is_joy_button_pressed(3, JOY_START):
		get_tree().change_scene_to(preload("res://intro.tscn"))
