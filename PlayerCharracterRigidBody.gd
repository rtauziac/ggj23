extends RigidBody2D

class_name Player

export (float) var WALK_SPEED = 1000
export (float) var JUMP_STRENGTH = 200
export (float) var COYOTE_TIME = 0.08
export (float) var TRAMPOLINE_STRENGTH = 1800
export var colliders = []

var jumpPressed = false
var _was_touching_trampoline = false

var resetPosition = null
var _coyote_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):



func _physics_process(delta):
	#Init
	var velocity = Vector2.ZERO
	velocity.x = Input.get_axis("moveLeft", "moveRight") * WALK_SPEED
	var _physics_fps = ProjectSettings.get("physics/common/physics_fps")

	colliders = get_colliding_bodies()
	var not_walls = []
	for _col in colliders:
		if not _col.get_parent().name == "invisible_walls":
			not_walls.push_front(_col)
	if not_walls.size() > 0:
		_coyote_time = COYOTE_TIME
		#Trampoline
		if not_walls[0] is Trampoline:
			if not _was_touching_trampoline:
				$TrampolineAudioStream.play()
				velocity.y = -TRAMPOLINE_STRENGTH * _physics_fps
			_was_touching_trampoline = true
		else:
			_was_touching_trampoline = false
	else:
		_was_touching_trampoline = false

	#Input
	
	#Jump
	if _coyote_time > 0 and jumpPressed != Input.is_action_pressed("jump") and Input.is_action_pressed("jump"):
		velocity.y = -JUMP_STRENGTH * _physics_fps
		$jumpAudio.play_random()
	jumpPressed = Input.is_action_pressed("jump")
	_coyote_time -= delta

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
