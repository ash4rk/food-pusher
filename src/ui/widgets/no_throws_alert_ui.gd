extends Control

@onready var alert_panel: PanelContainer = $Panel

func _ready() -> void:
	EventBus.on_remaining_throws_changed.connect(_on_remaining_throws_changed)

func _on_remaining_throws_changed(new_value):
	self.visible = !(new_value > 0)
