extends RigidBody2D

export (float) var  speed = 5
export (Vector2) var finishPosition = Vector2(300, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	move()
	
func move():
	$Tween.interpolate_property(
		self,
		"position",
		global_position,
		global_position + finishPosition,
		speed,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
		finishPosition = - finishPosition
		move()
