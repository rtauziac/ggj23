extends Node2D

export (NodePath) var robot_wheel
export (float) var rotate_scale = PI / 8.0
export (float) var gravity_amount = 0.1
onready var _robot_wheel = get_node(robot_wheel)


func _process(_delta):
	global_transform.origin = _robot_wheel.global_transform.origin
	
	
func _physics_process(delta):
	var _bucket_accel: Vector2 = $bucketpinpoint/Bucket.acceleration
	var _lean_factor = abs(Vector2.UP.rotated(rotation).dot(Vector2.LEFT))
	rotation = wrapf(rotation, -PI / 2.0, PI / 2.0)
#	if _bucket_accel.length() > 0.0001:
	var _rotate_amount = _bucket_accel.normalized().dot(Vector2.LEFT)
#	_rotate_amount += (-_lean_factor * gravity_amount if rotation > 0 else _lean_factor * gravity_amount) * delta
	rotate(_rotate_amount * rotate_scale * delta)
