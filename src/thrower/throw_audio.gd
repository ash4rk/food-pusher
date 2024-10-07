extends AudioStreamPlayer

@onready var sounds: Array = [
	preload("res://assets/sfx/kenney_casino/Audio/card-slide-3.ogg"),
	preload("res://assets/sfx/kenney_casino/Audio/card-slide-4.ogg"),
	preload("res://assets/sfx/kenney_casino/Audio/card-slide-5.ogg")
]

func play_throw_sound():
	self.stream = sounds[randi_range(0, sounds.size()-1)]
	self.pitch_scale = randf_range(2, 2.5)
	self.playing = true
