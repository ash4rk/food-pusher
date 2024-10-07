extends Node3D

@export var WATER_SPLASH_SCENE: PackedScene
@export var REWARD_POPUP_SCENE: PackedScene

@onready var object_remover: Area3D = $ObjectRemover
@onready var rewarded_object_remover: Area3D = $RewardedObjectRemover
@onready var reward_audio_player: AudioStreamPlayer = $RewardAudioPlayer

func _ready() -> void:
	object_remover.body_entered.connect(_on_body_drown)
	rewarded_object_remover.body_entered.connect(_on_rewarded_body_drown)

func _on_body_drown(body: Node3D):
	_sink_the_object(body)

func _on_rewarded_body_drown(body:Node3D):
	_sink_the_object(body)
	_spawn_popup(body.global_position, body.value)
	_play_reward_sound()
	EventBus.emit_signal("on_drowned_with_reward", body.value)
	print_rich("[color=purple]", "%s fell with the reward %s" % [body.name, body.value])

func _sink_the_object(object):
	var splash_instance: CPUParticles3D = WATER_SPLASH_SCENE.instantiate()
	get_parent().add_child(splash_instance)
	splash_instance.global_position = object.global_position
	splash_instance.emit_particles()
	await get_tree().create_timer(1.0).timeout
	if is_instance_valid(object):
		object.queue_free()

func _spawn_popup(pos: Vector3, value_to_show: int):
	var instance: Label3D = REWARD_POPUP_SCENE.instantiate()
	get_parent().add_child(instance)
	instance.text = "+%s" % str(value_to_show)
	instance.global_position = pos

func _play_reward_sound():
	reward_audio_player.pitch_scale = randf_range(0.8, 1.3)
	reward_audio_player.playing = true
