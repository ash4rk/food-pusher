extends Label3D

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector3(0.0, 4.0, 0.0), 
			5).as_relative().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "modulate", Color.TRANSPARENT,
			2.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(self, "outline_modulate", Color.TRANSPARENT,
			2.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	await tween.finished
	queue_free()
