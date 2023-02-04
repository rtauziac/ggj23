extends Area2D

func _on_TpToLevelBegining_body_entered(body : RigidBody2D):
	body.resetPosition = $Position2D.global_transform.origin
