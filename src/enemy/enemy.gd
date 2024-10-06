extends StaticBody3D

# TODO: Randomize mesh from assets/models/kenney_characters/*.glb
const MAX_HEALTH: int = 5
const BOX_POKE_LENGTH: float = 1.4

@onready var DATA_RES: Resource = load("res://data/valuables.tres")
@onready var anim_player: AnimationPlayer = $CharacterMesh/AnimationPlayer
@onready var food_detector: Area3D = $FoodDetector

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
	food_detector.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D):
	if body.is_in_group("foods"):
		self.health -= 1

func _anim_sequences(anim_name: String):
	match anim_name:
		"die":
			_spawn_box()
			queue_free()
		_:
			pass

func _spawn_box():
	randomize()
	var rnd = randf()
	var drop: RigidBody3D = DATA_RES.get_drop_by_chance(rnd)
	# TODO: Resolve this and avoid double get_parent
	get_parent().get_parent().add_child(drop)
	drop.global_position = self.global_position
	var enemy_back_vec = -global_transform.basis.z
	var poke_vec = enemy_back_vec + Vector3.UP
	drop.apply_central_impulse(poke_vec * BOX_POKE_LENGTH)
