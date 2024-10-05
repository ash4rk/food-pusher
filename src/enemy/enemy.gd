extends StaticBody3D

# TODO: Randomize mesh from assets/models/kenney_characters/*.glb

@onready var anim_player: AnimationPlayer = $CharacterMesh/AnimationPlayer

func _ready() -> void:
	anim_player.play("idle", -1, 0.65)
