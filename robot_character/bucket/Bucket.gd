extends Node2D


export (float, 0, 1) var smooth_movements: float = 0.1
onready var _prev_pos: Vector2 = transform.origin
var _velocity: Vector2 = Vector2.ZERO
var _acceleration: Vector2 = Vector2.ZERO
var _debug = true


func _process(delta):
	var _new_velocity = lerp(_velocity, (global_transform.origin - _prev_pos) * delta, smooth_movements)
	_acceleration = _new_velocity - _velocity
	_velocity = _new_velocity
	_prev_pos = global_transform.origin
	update()


func _draw():
	if _debug: # draw velocity vector
		draw_rect(Rect2(-5, -5, 10, 10), Color.rebeccapurple)
		draw_line(Vector2.ZERO, _velocity * 1000.0, Color.green)
		draw_line(_velocity * 1000, (_velocity * 1000) + (_acceleration * 10000), Color.blue)
