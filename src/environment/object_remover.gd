extends Area3D

@export var WATER_SPLASH_SCENE: PackedScene

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D):
	var splash_instance: CPUParticles3D = WATER_SPLASH_SCENE.instantiate()
	get_parent().add_child(splash_instance)
	splash_instance.global_position = body.global_position
	splash_instance.emit_particles()
	await get_tree().create_timer(1.0).timeout
	body.queue_free()
