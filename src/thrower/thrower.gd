extends Node3D
class_name Thrower

# TODO: Choose random food from src/foods/*.tscn
@export var FOOD_DIR_PATH: String = "res://src/valuables/foods/"
@export var Z_THROW_VEC_LENGTH: float = 12.4
@export var Y_THROW_VEC_LENGTH: float = 1.75
@export var MOVEMENT_APLITUDE: float = 1.0
# TODO: Get rid of it
@export var mass = 1.0
@export var gravity_scale = 1.0

@onready var moving_holder: Node3D = $MovingHolder
@onready var tween: Tween = get_tree().create_tween()

var _food_scenes: Array = []

func _ready() -> void:
	start_moving_loop()
	_food_scenes = _load_food_scenes(FOOD_DIR_PATH)

func start_moving_loop():
	moving_holder.position.x = MOVEMENT_APLITUDE
	tween.set_loops().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(moving_holder, "position", Vector3(-MOVEMENT_APLITUDE, 0, 0), 1.5)
	tween.tween_property(moving_holder, "position", Vector3(MOVEMENT_APLITUDE, 0, 0), 1.5)

func _input(event: InputEvent) -> void:
	if event.is_pressed() and Input.is_key_pressed(KEY_SPACE):
		throw()

func throw():
	var food = _create_random_food()
	var z_comp = -moving_holder.basis.z * Z_THROW_VEC_LENGTH
	var y_comp = moving_holder.basis.y * Y_THROW_VEC_LENGTH
	var throw_vec: Vector3 = z_comp + y_comp
	food.freeze = false
	food.mass = mass
	food.gravity_scale = gravity_scale
	food.apply_impulse(throw_vec)

func _create_random_food():
	randomize()
	var rand_food = _food_scenes[randi() % _food_scenes.size()]
	var instance = rand_food.instantiate()
	instance.position = moving_holder.position
	self.add_child(instance)
	return instance

# TODO: Log it
func _load_food_scenes(food_dir_path: String):
	var res: Array = []
	var dir = DirAccess.open(food_dir_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var file_path = food_dir_path + '/' + file_name
			res.push_back(load(file_path))
			file_name = dir.get_next()
	else:
		push_error("An error occurred when trying to access the path.")
	return res
