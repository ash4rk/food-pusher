extends RigidBody3D


func _ready() -> void:
	await get_tree().create_timer(4.0).timeout
	self.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
