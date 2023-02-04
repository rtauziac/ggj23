extends RigidBody2D


export (float) var WALK_SPEED = 1000
export (float) var JUMP_STRENGTH = 12000

export (float) var TRAMPOLINE_STRENGTH = 5000
export var colliders = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):dddzzd
#	passddddddddddddddz


func _physics_process(delta):
	#Init
	var velocity = Vector2.ZERO
	
	# Lateral movement
	if Input.is_action_pressed("moveLeft"):
		velocity.x -= WALK_SPEED
	if Input.is_action_pressed("moveRight"):
		velocity.x += WALK_SPEED
	
	#Jump
	if Input.is_action_pressed("jump") and linear_velocity.y == 0:
		velocity.y = -JUMP_STRENGTH

#	Trampoline
	colliders = get_colliding_bodies()
	if colliders.size() > 0 && colliders[0] is Trampoline:
		velocity.y = -TRAMPOLINE_STRENGTH

	#Forces applying
	apply_central_impulse(velocity * delta)
