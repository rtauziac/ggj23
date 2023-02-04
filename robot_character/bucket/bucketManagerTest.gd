extends Node2D

var _mouse_global_pos: Vector2


func _process(delta):
	_mouse_global_pos = get_global_mouse_position()
	var _vec_to_mouse = _mouse_global_pos - global_transform.origin
	$bucket_empty.rotation = -_vec_to_mouse.angle_to(Vector2.UP)
	update()


func _draw():
	draw_line(Vector2.ZERO, _mouse_global_pos - global_transform.origin, Color.green)
