extends Node3D
class_name Thrower
# TODO: Choose random fruit from src/fruits/*.tscn
@export var FRUIT_SCENE: PackedScene
@export var Z_THROW_VEC_LENGTH: float = 12.4
@export var Y_THROW_VEC_LENGTH: float = 1.75
@export var MOVEMENT_APLITUDE: float = 1.0
@export var mass = 1.0
@export var gravity_scale = 1.0

@onready var moving_holder: Node3D = $MovingHolder
@onready var tween: Tween = get_tree().create_tween()

func _ready() -> void:
	start_moving_loop()

func start_moving_loop():
	moving_holder.position.x = MOVEMENT_APLITUDE
	tween.set_loops().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(moving_holder, "position", Vector3(-MOVEMENT_APLITUDE, 0, 0), 1.5)
	tween.tween_property(moving_holder, "position", Vector3(MOVEMENT_APLITUDE, 0, 0), 1.5)

func _input(event: InputEvent) -> void:
	if event.is_pressed() and Input.is_key_pressed(KEY_SPACE):
		throw()

func throw():
	var fruit = _create_fruit()
	var z_comp = -moving_holder.basis.z * Z_THROW_VEC_LENGTH
	var y_comp = moving_holder.basis.y * Y_THROW_VEC_LENGTH
	var throw_vec: Vector3 = z_comp + y_comp
	fruit.freeze = false
	fruit.mass = mass
	fruit.gravity_scale = gravity_scale
	fruit.apply_impulse(throw_vec)

func _create_fruit():
	var instance = FRUIT_SCENE.instantiate()
	instance.position = moving_holder.position
	self.add_child(instance)
	return instance
