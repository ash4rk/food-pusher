extends Node

# TODO: Implement FreeCam (mouse rotation, wasd movement)
func _input(event: InputEvent) -> void:
	if !event.is_pressed() or event.is_echo():
		return
	
	if Input.is_key_pressed(KEY_C):
		self.current = !self.current

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN):
		self.fov = min(self.fov+5, 150)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP):
		self.fov = max(self.fov-5, 5)
