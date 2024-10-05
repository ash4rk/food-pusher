extends Node

@onready var debug_cam: Camera3D = $DebugCamera

func _input(event: InputEvent) -> void:
	if !event.is_pressed() or event.is_echo():
		return
	
	if Input.is_key_pressed(KEY_C):
		debug_cam.current = !debug_cam.current
