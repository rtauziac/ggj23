extends Node2D


export (float) var distance := 100.0
var _elaped_time := 0.0


func _process(delta):
	_elaped_time += delta
	$Bucket.transform.origin = get_global_mouse_position()

