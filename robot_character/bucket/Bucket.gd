extends Node2D

signal water_level_changed


export (float, 0, 1) var smooth_movements: float = 0.1
export (float, 0, 1) var water_damp = 0.9
export (float, 0, 1) var initial_water_amount = 0.85
export (float) var water_loss_rate = 0.8
onready var _prev_pos: Vector2 = transform.origin
var velocity: Vector2 = Vector2.ZERO
var acceleration: Vector2 = Vector2.ZERO
var _debug = false
onready var water_amount: float = initial_water_amount
#var _ang_vel: float = 0.0


func _ready():
	_prev_pos = global_transform.origin
	$BackBufferCopy/Node2D/Node2D/water.material.set("shader_param/waterLevel", water_amount)


func _process(delta):
#	var _vec_water: Vector2 = $BackBufferCopy/Node2D/Node2D/Position2D.global_transform.origin - global_transform.origin
#	var _angle_grav = _vec_water.angle_to(Vector2.DOWN)
#	print(_angle_grav)
#	_ang_vel += (_angle_grav * delta) * 0.4
#	_ang_vel = lerp(_ang_vel, 0, min(delta, 1))
#	$BackBufferCopy/Node2D/Node2D.rotate(_ang_vel)
	var tilt_level = clamp(Vector2.UP.rotated(global_rotation).dot(Vector2.UP), 0.0, 1.0)
#	print(tilt_level)
	if tilt_level < water_amount:
		water_amount = max(water_amount - delta * initial_water_amount * water_loss_rate, 0)
		#print(water_amount)
		$BackBufferCopy/Node2D/Node2D/water.material.set("shader_param/waterLevel", water_amount)
		emit_signal("water_level_changed", water_amount / initial_water_amount)
	update()


func _physics_process(delta):
	var _new_velocity = lerp(velocity, (global_transform.origin - _prev_pos) * delta, smooth_movements)
	acceleration = _new_velocity - velocity
	velocity = _new_velocity
	_prev_pos = global_transform.origin


func _draw():
	if _debug: # draw velocity vector
		draw_rect(Rect2(-5, -5, 10, 10), Color.rebeccapurple)
		draw_line(Vector2.ZERO, velocity * 1000.0, Color.green)
		draw_line(velocity * 1000, (velocity * 1000) + (acceleration * 10000), Color.blue)


func refill(_body: Node) -> void:
	water_amount = initial_water_amount
	$BackBufferCopy/Node2D/Node2D/water.material.set("shader_param/waterLevel", water_amount)
	emit_signal("water_level_changed", water_amount / initial_water_amount)
