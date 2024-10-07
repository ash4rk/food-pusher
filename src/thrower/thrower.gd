extends Node3D
class_name Thrower

#region: --- Event Bus Callbacks ---
func _update_remaining_throws(new_value):
	remaining_throws = new_value
#endregion

const HOLDER_ROTATION_SPEED = 5

@export var FOOD_DIR_PATH: String = "res://src/valuables/foods"
@export var Z_THROW_VEC_LENGTH: float = 7.05
@export var Y_THROW_VEC_LENGTH: float = 2.225
@export var MOVEMENT_APLITUDE: float = 1.0

@onready var moving_holder: Node3D = $MovingHolder
@onready var throw_audio_player: AudioStreamPlayer = $ThrowAudioPlayer
@onready var tween: Tween = get_tree().create_tween()

var _food_scenes: Array = []
var food_in_holder: RigidBody3D = null
var remaining_throws: int = 0

func _ready() -> void:
	_start_moving_loop()
	_food_scenes = _load_food_scenes(FOOD_DIR_PATH)
	food_in_holder = create_random_food()
	EventBus.on_remaining_throws_changed.connect(_update_remaining_throws)

func _process(delta: float) -> void:
	moving_holder.rotate_y(delta * HOLDER_ROTATION_SPEED)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("throw"):
		if remaining_throws > 0:
			throw(food_in_holder)
			EventBus.emit_signal("on_remaining_throws_changed", remaining_throws - 1)
			food_in_holder = create_random_food()
		else:
			print("There are no throws left")

func _start_moving_loop():
	moving_holder.position.x = MOVEMENT_APLITUDE
	tween.set_loops().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(moving_holder, "position", Vector3(-MOVEMENT_APLITUDE, 0, 0), 1.5)
	tween.tween_property(moving_holder, "position", Vector3(MOVEMENT_APLITUDE, 0, 0), 1.5)

func throw(food_to_throw: RigidBody3D):
	throw_audio_player.play_throw_sound()
	food_to_throw.reparent(get_parent())
	var z_comp = -self.basis.z * Z_THROW_VEC_LENGTH
	var y_comp = self.basis.y * Y_THROW_VEC_LENGTH
	var throw_vec: Vector3 = z_comp + y_comp
	food_to_throw.freeze = false
	food_to_throw.collision_layer = 1
	food_to_throw.apply_impulse(throw_vec)

func create_random_food():
	randomize()
	var rand_food = _food_scenes[randi() % _food_scenes.size()]
	var instance = rand_food.instantiate()
	moving_holder.add_child(instance)
	instance.freeze = true
	instance.collision_layer = 2
	instance.global_position = moving_holder.global_position
	print_rich("[color=yellow]", "got random food: %s" % instance.name)
	return instance

func _load_food_scenes(food_dir_path: String) -> Array:
	var res: Array = []
	var file_paths = Utilities.get_files_by_filter(food_dir_path, ".tscn")
	for path in file_paths:
		res.push_back(load(path))
		print_rich("[color=orange]", "loading food scenes: found %s " % [path])
	print_rich("[color=orange]", "loaded %s foods" % res.size())
	return res
