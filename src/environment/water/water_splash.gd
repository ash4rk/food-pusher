extends CPUParticles3D

@onready var droplets_particles = $Droplets
@onready var stream_player = $AudioStreamPlayer
@onready var sounds: Array = [
	preload("res://assets/sfx/water_splash_1.mp3"),
	preload("res://assets/sfx/water_splash_2.mp3"),
	preload("res://assets/sfx/water_splash_3.mp3")
]

func _ready() -> void:
	self.finished.connect(_on_finished)
	stream_player.stream = sounds[randi_range(0, sounds.size()-1)]
	stream_player.pitch_scale = randf_range(0.8, 1.5)
	stream_player.playing = true

func emit_particles():
	self.emitting = true
	droplets_particles.emitting = true

func _on_finished():
	self.queue_free()
