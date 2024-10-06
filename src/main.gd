extends Node

func _ready() -> void:
	EventBus.emit_signal("on_remaining_throws_changed", 100)
