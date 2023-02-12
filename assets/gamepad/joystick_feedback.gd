extends Sprite


export (float) var joystick_offset: float = 5.0
export (int) var horizontal_index
export (int) var vertical_index
onready var _start_pos = position


func _process(_delta: float) -> void:
	var _joy_offset = Vector2(Input.get_joy_axis(0, horizontal_index), Input.get_joy_axis(0, vertical_index))
	_joy_offset += Vector2(Input.get_joy_axis(1, horizontal_index), Input.get_joy_axis(1, vertical_index))
	_joy_offset += Vector2(Input.get_joy_axis(2, horizontal_index), Input.get_joy_axis(2, vertical_index))
	_joy_offset += Vector2(Input.get_joy_axis(3, horizontal_index), Input.get_joy_axis(3, vertical_index))
	position = _start_pos + _joy_offset * joystick_offset
