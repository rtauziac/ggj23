extends RigidBody2D


export (float) var WALK_SPEED = 1000
export (float) var JUMP_SPEED = 10

var isJumping = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):dddzzd
#	pass


func _physics_process(delta):
	#Init
	var horVelocity = Vector2.ZERO
	
	# Lateral movement
	if Input.is_action_pressed("moveLeft"):
		horVelocity.x -= 1
	if Input.is_action_pressed("moveRight"):
		horVelocity.x +=  1
	apply_central_impulse(horVelocity * WALK_SPEED * delta)
	
	#Jump
	if Input.is_action_pressed("jump") && not isJumping:
		isJumping = true
		apply_central_impulse(Vector2(0, -1 * JUMP_SPEED))



