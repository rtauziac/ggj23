extends Node2D

export (NodePath) var robot_wheel
export (float) var rotate_scale = PI / 8.0
export (float) var gravity_amount = 150.0
onready var _robot_wheel = get_node(robot_wheel)
onready var _bucket = $bucketpinpoint/bucket_empty
var _prev_water_level = 1
var _water_level_on_signal = 1


func _process(_delta):
	global_transform.origin = _robot_wheel.global_transform.origin
	$bucketpinpoint/CPUParticles2D.emitting = _prev_water_level != _water_level_on_signal
	_prev_water_level = _water_level_on_signal
	
	
func _physics_process(delta):
	if $bucketpinpoint/bucket_empty == null:
		return
	var _bucket_accel: Vector2 = $bucketpinpoint/bucket_empty.acceleration
	var _lean_factor = abs(Vector2.UP.rotated(rotation).dot(Vector2.LEFT))
	rotation = clamp(rotation, -PI / 2.0, PI / 2.0)
	var _rotate_amount = _bucket_accel.normalized().dot(Vector2.LEFT)
	var _add_lean_amount = (_lean_factor * gravity_amount if rotation > 0 else -_lean_factor * gravity_amount) * delta
	_rotate_amount += _add_lean_amount
	if Input.is_action_pressed("balanceLeft"):
		_rotate_amount -= gravity_amount * delta * 1.5
	if Input.is_action_pressed("balanceRight"):
		_rotate_amount += gravity_amount * delta * 1.5
	
	rotate(_rotate_amount * rotate_scale * delta)


func _on_bucket_empty_water_level_changed(level):
	_water_level_on_signal = level
