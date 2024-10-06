extends Node3D
class_name Thrower

#region: EventBus Callbacks
func _update_remaining_throws(new_value):
	remaining_throws = new_value
#endregion

const HOLDER_ROTATION_SPEED = 5

@export var FOOD_DIR_PATH: String = "res://src/valuables/foods/"
@export var Z_THROW_VEC_LENGTH: float = 7.05
@export var Y_THROW_VEC_LENGTH: float = 2.225
@export var MOVEMENT_APLITUDE: float = 1.0

@onready var moving_holder: Node3D = $MovingHolder
@onready var tween: Tween = get_tree().create_tween()

var _food_scenes: Array = []
var _food_in_holder: RigidBody3D = null
var remaining_throws: int = 0

func _ready() -> void:
	start_moving_loop()
	_food_scenes = _load_food_scenes(FOOD_DIR_PATH)
	_food_in_holder = _create_random_food()
	EventBus.on_remaining_throws_changed.connect(_update_remaining_throws)

func _process(delta: float) -> void:
	moving_holder.rotate_y(delta * HOLDER_ROTATION_SPEED)

func _input(event: InputEvent) -> void:
	# TODO: Declare action name
	if event.is_pressed() and Input.is_key_pressed(KEY_SPACE):
		if remaining_throws > 0:
			throw(_food_in_holder)
			EventBus.emit_signal("on_remaining_throws_changed", remaining_throws - 1)
			_food_in_holder = _create_random_food()
		else:
			print("There are no throws left")

func start_moving_loop():
	moving_holder.position.x = MOVEMENT_APLITUDE
	tween.set_loops().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(moving_holder, "position", Vector3(-MOVEMENT_APLITUDE, 0, 0), 1.5)
	tween.tween_property(moving_holder, "position", Vector3(MOVEMENT_APLITUDE, 0, 0), 1.5)

func throw(food_to_throw: RigidBody3D):
	_food_in_holder.reparent(get_parent())
	var z_comp = -self.basis.z * Z_THROW_VEC_LENGTH
	var y_comp = self.basis.y * Y_THROW_VEC_LENGTH
	var throw_vec: Vector3 = z_comp + y_comp
	_food_in_holder.freeze = false
	_food_in_holder.apply_impulse(throw_vec)
	var thrown = _food_in_holder
	thrown.collision_layer = 1

func _create_random_food():
	randomize()
	var rand_food = _food_scenes[randi() % _food_scenes.size()]
	var instance = rand_food.instantiate()
	moving_holder.add_child(instance)
	instance.freeze = true
	instance.collision_layer = 2
	instance.global_position = moving_holder.global_position
	return instance

# TODO: Log it
func _load_food_scenes(food_dir_path: String) -> Array:
	var res: Array = []
	var file_paths = Utilities.get_files_by_filter(food_dir_path, ".tscn")
	for path in file_paths:
		res.push_back(load(path))
	return res
