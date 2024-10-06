extends Control

@onready var promos_label: Label = $Panel/VBox/PromosLabels/Value:
	set(new_value):
		promos_label.text = str(max(0, new_value))
@onready var throws_label: Label = $Panel/VBox/ThrowsLabels/Value:
	set(new_value):
			throws_label.text = str(max(0, new_value))
@onready var rewards_label: Label = $Panel/VBox/RewardsLabels/Value:
	set(new_value):
		rewards_label.text = str(max(0, new_value))
