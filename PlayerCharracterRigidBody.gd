extends RigidBody2D

class_name Player

export (float) var WALK_SPEED = 1000
export (float) var JUMP_STRENGTH = 12000

export (float) var TRAMPOLINE_STRENGTH = 5000
export var colliders = []

var jumpPressed = false

var resetPosition = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):



func _physics_process(delta):
	#Init
	var velocity = Vector2.ZERO
	velocity.x = Input.get_axis("moveLeft", "moveRight") * WALK_SPEED

	colliders = get_colliding_bodies()
	if colliders.size() > 0:
		#Jump
		if jumpPressed != Input.is_action_pressed("jump") and Input.is_action_pressed("jump"):
			velocity.y = -JUMP_STRENGTH
		#Trampoline
		if colliders[0] is Trampoline:
			velocity.y = -TRAMPOLINE_STRENGTH

	#Input
	jumpPressed = Input.is_action_pressed("jump")

	#Forces applying
	apply_central_impulse(velocity * delta)
	apply_torque_impulse(velocity.x * delta * 20.0)
	
	
func _integrate_forces(state : Physics2DDirectBodyState):
	if resetPosition != null:
		var t = state.transform
		t.origin.x = resetPosition.x
		t.origin.y = resetPosition.y
		state.transform = t
		resetPosition = null
