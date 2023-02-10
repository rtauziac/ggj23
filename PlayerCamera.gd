extends Camera2D

export (NodePath) var end_camera
onready var end_camera_node: Camera2D = get_node(end_camera)

func _on_end_cinematic_trigger():
	var _cur_pos = global_position
	get_parent().remove_child(self)
	end_camera_node.get_parent().add_child(self)
	$Tween.interpolate_property(self, "global_position", _cur_pos, 
	end_camera_node.global_position, 4, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()


func _on_Area2D_body_entered(body):
	if GlobalVariables.bucket.auto_balance == false:
		_on_end_cinematic_trigger()
		yield(get_tree(), "idle_frame")
		GlobalVariables.bucket.auto_balance = true
