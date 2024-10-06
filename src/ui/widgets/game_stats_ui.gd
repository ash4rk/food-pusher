extends Control

#region: --- Event Bus Callbacks ---
func _on_promos_changed(new_value):
	promos_label.text = str(max(0, new_value))

func _on_remaining_throws_changed(new_value):
	throws_label.text = str(max(0, new_value))

func _on_rewards_changed(new_value):
	rewards_label.text = str(max(0, new_value))
#endregion

@onready var promos_label: Label = $Panel/VBox/PromosLabels/Value
@onready var throws_label: Label = $Panel/VBox/ThrowsLabels/Value
@onready var rewards_label: Label = $Panel/VBox/RewardsLabels/Value

func _ready() -> void:
	EventBus.on_promos_changed.connect(_on_promos_changed)
	EventBus.on_remaining_throws_changed.connect(_on_remaining_throws_changed)
	EventBus.on_rewards_changed.connect(_on_rewards_changed)
	
