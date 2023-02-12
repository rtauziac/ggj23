extends Sprite


export (float) var vertical_offset: float = 5.0
export (int) var button_index
onready var _start_pos = position


func _process(_delta: float) -> void:
	var pressed = Input.is_physical_key_pressed(button_index)
	position = _start_pos + (Vector2.DOWN * (vertical_offset if pressed else 0))
