extends StaticBody3D

# TODO: Randomize mesh from assets/models/kenney_characters/*.glb
const MAX_HEALTH: int = 5

@onready var anim_player: AnimationPlayer = $CharacterMesh/AnimationPlayer
@onready var fruit_detector: Area3D = $CoinDetector

var health = MAX_HEALTH :
	set(new_value):
		if new_value < health:
			if new_value > 0:
				anim_player.play("emote-no")
			else:
				anim_player.play("die")
		health = max(new_value, 0)

func _ready() -> void:
	anim_player.animation_set_next("emote-no", "idle")

	anim_player.play("idle", -1, 0.65)
	anim_player.animation_finished.connect(_anim_sequences)
	fruit_detector.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D):
	if body.is_in_group("fruits"):
		self.health -= 1
 
func _anim_sequences(anim_name: String):
	match anim_name:
		"die":
			_spawn_box()
			queue_free()
		_:
			pass

func _spawn_box():
	pass
