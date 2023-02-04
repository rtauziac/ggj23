extends RigidBody2D


export (float) var WALK_SPEED = 1000


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	var horVelocity = Vector2.ZERO
	# Lateral movement
	if Input.is_action_pressed("moveLeft"):
		horVelocity.x -= 1
	if Input.is_action_pressed("moveRight"):
		horVelocity.x +=  1
	
	print(horVelocity * WALK_SPEED * delta)

	apply_central_impulse(horVelocity * WALK_SPEED * delta)
