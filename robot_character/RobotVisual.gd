extends Node2D

export (NodePath) var robot_wheel
onready var _robot_wheel = get_node(robot_wheel)


func _process(_delta):
	global_transform.origin = _robot_wheel.global_transform.origin
