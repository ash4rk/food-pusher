extends Node3D

@export var ENEMY_SPOT_HEIGHT: float = -0.658
@export var RADIUS: float = 1.51
# TODO: Replace enemy scene by spot scene
@export var SPOT_SCENE: PackedScene
@export var ROTATION_SPEED: float = 0.2

@onready var enemy_group = $EnemyGroup

func _ready() -> void:
	_gen_enemy_spots(RADIUS, 12, SPOT_SCENE)

func _process(delta: float) -> void:
	rotate_object_local(Vector3.UP, -ROTATION_SPEED * delta)

func _gen_enemy_spots(radius: float, spots_num: int, spot_scene: PackedScene) -> void:
	var angle_step = 360.0 / spots_num
	for i in range(spots_num):
		var angle_radians = deg_to_rad(i * angle_step)
		var x = radius * cos(angle_radians)
		var z = radius * -sin(angle_radians)
		var instance = spot_scene.instantiate()
		enemy_group.add_child(instance)
		instance.position = Vector3(x, ENEMY_SPOT_HEIGHT, z)
		instance.rotation.y = (angle_radians + deg_to_rad(90))
		instance.world = get_parent()

func respawn_enemies():
	for child in enemy_group.get_children():
		child.queue_free()
	_gen_enemy_spots(RADIUS, 12, SPOT_SCENE)
