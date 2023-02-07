extends Node2D

signal is_leaking_state_change(state) 


export (NodePath) var robot_wheel
export (float) var rotate_scale = PI / 8.0
export (float) var gravity_amount = 150.0
export (bool) var auto_balance = false
onready var _robot_wheel = get_node(robot_wheel)
onready var _bucket = $bucketpinpoint/bucket_empty
var _prev_water_level = 1
var _water_level_on_signal = 1
var _was_leaking = false


func _ready():
	GlobalVariables.bucket = self


func is_leaking():
	return _prev_water_level > _water_level_on_signal


func _process(_delta):
	global_transform.origin = _robot_wheel.global_transform.origin
	$bucketpinpoint/CPUParticles2D.emitting = is_leaking()
	if _was_leaking != is_leaking():
		emit_signal("is_leaking_state_change", is_leaking())
		
	_prev_water_level = _water_level_on_signal
	_was_leaking = is_leaking()
	if _water_level_on_signal == 0 and auto_balance == false:
		auto_balance = true
	
	
func _physics_process(delta):
	if $bucketpinpoint/bucket_empty == null:
		return
	var _bucket_accel: Vector2 = $bucketpinpoint/bucket_empty.acceleration
	var _lean_factor = abs(Vector2.UP.rotated(rotation).dot(Vector2.LEFT))
	rotation = clamp(rotation, -PI / 2.0, PI / 2.0)
	var _rotate_amount = _bucket_accel.normalized().dot(Vector2.LEFT)
	var _add_lean_amount = (_lean_factor * gravity_amount if rotation > 0 else -_lean_factor * gravity_amount) * delta
	_rotate_amount += _add_lean_amount
#	if Input.is_action_pressed("balanceLeft"):
#		_rotate_amount -= gravity_amount * delta * 1.5
#	if Input.is_action_pressed("balanceRight"):
#		_rotate_amount += gravity_amount * delta * 1.5
	_rotate_amount += Input.get_axis("balanceLeft", "balanceRight") * delta * 260
	
	if auto_balance:
		_rotate_amount = -rotation * 0.1
	
	rotate(_rotate_amount * rotate_scale * delta)
	if auto_balance:
		rotate(-rotation * 0.07)


func _on_bucket_empty_water_level_changed(level):
	_water_level_on_signal = level
