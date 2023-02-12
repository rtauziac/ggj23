extends Sprite


export (float) var vertical_offset: float = 5.0
export (int) var button_index
onready var _start_pos = position


func _process(_delta: float) -> void:
	var pressed = Input.is_joy_button_pressed(0, button_index) or Input.is_joy_button_pressed(1, button_index) or Input.is_joy_button_pressed(2, button_index) or Input.is_joy_button_pressed(3, button_index)
	position = _start_pos + (Vector2.DOWN * (vertical_offset if pressed else 0))
