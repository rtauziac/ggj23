extends KinematicBody2D

export var GRAVITY = 1200
export var WALK_SPEED = 200
export var JUMP_SPEED = -400

var isJumping = false

var velocity = Vector2()

func _physics_process(delta):
	# Lateral movement
	if Input.is_action_pressed("moveLeft"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("moveRight"):
		velocity.x =  WALK_SPEED
	else:
		velocity.x = 0

	#Jump
	if Input.is_action_pressed("jump") && is_on_floor():
		isJumping = true
		velocity.y = JUMP_SPEED

	#if isJumping and is_on_floor():
		#isJumping = false

	#Gravity
	velocity.y += delta * GRAVITY

	move_and_slide_with_snap(velocity, Vector2(0, -1))
	
	print (is_on_floor())
