extends StaticBody3D

const FOODS_PATH = "res://src/valuables/foods/"

@onready var pregeneretaed_foods: Node3D = $PregeneratedFoods

func _ready() -> void:
	_pregenerate_grid_of_foods(7, 5, 0.32, 0.32)

func _pregenerate_grid_of_foods(num_rows, num_columns, row_gap, column_gap):
	var food_paths = Utilities.get_files_by_filter(FOODS_PATH, ".tscn")
	randomize()
	for i in range(num_rows):
		for j in range(num_columns):
			var food_path = food_paths[randi() % food_paths.size()]
			var instance = load(food_path).instantiate()
			pregeneretaed_foods.add_child(instance)
			instance.position = Vector3(i*row_gap, 0.0, -j*column_gap)
			instance.freeze = false
