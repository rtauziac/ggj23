extends KinematicBody2D

export var GRAVITY = 1200
export var WALK_SPEED = 200
export var JUMP_SPEED = -800

var isJumping = false
var counter = 0

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

	#Gravity
	if not is_on_floor():
		counter += 1
		print("add gravity")
		print(counter)
		velocity.y += delta * GRAVITY

	move_and_slide(velocity, Vector2(0, -1))
	
