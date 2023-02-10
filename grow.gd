extends AnimationPlayer


func _on_Area2D_body_entered(body):
	if not GlobalVariables.bucket.auto_balance:
		play("grow")
