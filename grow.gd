extends AnimationPlayer


func _on_Area2D_body_entered(body):
	play("grow")
