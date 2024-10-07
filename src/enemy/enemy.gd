extends StaticBody3D

const MAX_HEALTH: int = 5
const BOX_POKE_LENGTH: float = 1.4
const MODELS_PATH: String = "res://assets/models/kenney_characters/"

@onready var DATA_RES: Resource = load("res://data/valuables.tres")
@onready var startup_mesh: Node3D = $CharacterMesh
@onready var anim_player: AnimationPlayer = $CharacterMesh/AnimationPlayer
@onready var food_detector: Area3D = $FoodDetector

var world: Node3D = null

var health = MAX_HEALTH :
	set(new_value):
		if new_value < health:
			if new_value > 0:
				anim_player.play("emote-no")
			else:
				anim_player.play("die")
		health = max(new_value, 0)

func _ready() -> void:
	_set_random_mesh()
	anim_player.animation_set_next("emote-no", "idle")
	anim_player.play("idle", -1, 0.65)
	anim_player.animation_finished.connect(_anim_sequences)
	food_detector.body_entered.connect(_on_body_entered)

func _set_random_mesh():
	var model_paths = Utilities.get_files_by_filter(MODELS_PATH, ".glb")
	var rand_model_path = model_paths[randi() % model_paths.size()]
	var model_instance = load(rand_model_path).instantiate()
	self.add_child(model_instance)
	anim_player = model_instance.get_node_or_null("AnimationPlayer")
	if model_instance == null or anim_player == null:
		push_error("Invalid model instasnce: %s from path: %s" % [model_instance, rand_model_path])
		return
	startup_mesh.queue_free()

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
	self.world.add_child(drop)
	drop.global_position = self.global_position
	var enemy_back_vec = -global_transform.basis.z
	var poke_vec = enemy_back_vec + Vector3.UP
	drop.apply_central_impulse(poke_vec * BOX_POKE_LENGTH)
