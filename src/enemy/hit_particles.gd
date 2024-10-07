extends CPUParticles3D

func _ready() -> void:
	self.finished.connect(_on_finished)
	self.emitting = true

func _on_finished():
	self.queue_free()
