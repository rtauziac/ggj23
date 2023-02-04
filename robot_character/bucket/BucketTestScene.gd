extends Node2D


export (float) var distance := 100.0
var _elaped_time := 0.0


func _process(delta):
	_elaped_time += delta
	#$Bucket.transform.origin = Vector2(cos(_elaped_time), sin(_elaped_time)) * distance
	
	$Bucket.transform.origin = get_global_mouse_position() #get_viewport().get_global_mouse_position()

