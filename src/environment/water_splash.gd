extends CPUParticles3D

@onready var droplets_particles = $Droplets

func _ready() -> void:
	self.finished.connect(_on_finished)

func emit_particles():
	self.emitting = true
	droplets_particles.emitting = true

func _on_finished():
	self.queue_free()
