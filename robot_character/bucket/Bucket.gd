extends Node2D


export (float, 0, 1) var smooth_movements: float = 0.1
onready var _prev_pos: Vector2 = transform.origin
var velocity: Vector2 = Vector2.ZERO
var acceleration: Vector2 = Vector2.ZERO
var _debug = true


func _ready():
	_prev_pos = global_transform.origin


func _process(delta):
	var _new_velocity = lerp(velocity, (global_transform.origin - _prev_pos) * delta, smooth_movements)
	acceleration = _new_velocity - velocity
	velocity = _new_velocity
	_prev_pos = global_transform.origin
	print(acceleration.x)
	update()


func _draw():
	if _debug: # draw velocity vector
		draw_rect(Rect2(-5, -5, 10, 10), Color.rebeccapurple)
		draw_line(Vector2.ZERO, velocity * 1000.0, Color.green)
		draw_line(velocity * 1000, (velocity * 1000) + (acceleration * 10000), Color.blue)
