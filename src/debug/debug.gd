extends Node

@onready var debug_cam: Camera3D = $DebugCamera

func _input(event: InputEvent) -> void:
	if !event.is_pressed() or event.is_echo():
		return
	
	if Input.is_key_pressed(KEY_C):
		debug_cam.current = !debug_cam.current

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN):
		debug_cam.fov = min(debug_cam.fov+5, 150)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP):
		debug_cam.fov = max(debug_cam.fov-5, 5)
