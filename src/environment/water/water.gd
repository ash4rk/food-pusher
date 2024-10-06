extends Node3D

@export var WATER_SPLASH_SCENE: PackedScene

@onready var object_remover: Area3D = $ObjectRemover
@onready var rewarded_object_remover: Area3D = $RewardedObjectRemover

func _ready() -> void:
	object_remover.body_entered.connect(_on_body_drown)
	rewarded_object_remover.body_entered.connect(_on_rewarded_body_drown)

func _on_body_drown(body: Node3D):
	_sink_the_object(body)

func _on_rewarded_body_drown(body:Node3D):
	_sink_the_object(body)
	EventBus.emit_signal("on_rewards_changed", body.value)

func _sink_the_object(object):
	var splash_instance: CPUParticles3D = WATER_SPLASH_SCENE.instantiate()
	get_parent().add_child(splash_instance)
	splash_instance.global_position = object.global_position
	splash_instance.emit_particles()
	await get_tree().create_timer(1.0).timeout
	if is_instance_valid(object):
		object.queue_free()
