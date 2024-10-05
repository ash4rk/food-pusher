extends Node3D

@onready var apple: RigidBody3D = $FruitThrower

@onready var _init_pos: Transform3D = apple.transform

func _ready() -> void:
	apple.freeze = false
	var z_comp = -apple.basis.z * 8.5
	var y_comp = apple.basis.y * 4.0
	var throw_vec: Vector3 = z_comp + y_comp
	apple.apply_impulse(throw_vec)
	
	await get_tree().create_timer(1.0).timeout
	apple.freeze = true
	apple.inertia = Vector3.ZERO
	apple.transform = _init_pos
	_ready()
