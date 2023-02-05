extends KinematicBody2D
export (float) var radius = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	print(radius)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _draw():
	draw_circle(Vector2.ZERO, 150, Color.orangered)
