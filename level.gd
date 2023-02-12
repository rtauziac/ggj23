extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("debug_restart"):
		get_tree().reload_current_scene()


func _go_to_end_screen():
	get_tree().change_scene_to(preload("res://ending.tscn"))
