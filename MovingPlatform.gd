extends RigidBody2D

export (float) var speed = 5

export (int, 0, 10) var transition_type = Tween.TRANS_LINEAR
export (bool) var inout = true
onready var _initial_position: Vector2 = global_position
onready var _destination_position: Vector2 = $TargetPosition.global_position
var ping = true


# Called when the node enters the scene tree for the first time.
func _ready():
	move()
	
func move():
	$Tween.interpolate_property(
		self,
		"position",
		_initial_position if ping else _destination_position,
		_destination_position if ping else _initial_position,
		speed,
		transition_type,
		Tween.EASE_IN_OUT if inout else Tween.EASE_OUT
	)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
		ping = not ping
		move()
