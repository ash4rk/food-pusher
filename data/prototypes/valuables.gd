extends Resource
class_name ValuablesData

@export_category("Ticket Value")
@export var drops: Dictionary = {
	"Food (aka coin)": { 
		"value": 1,
		"drop_chance": 0,
		"packed_scene" : "res://src/valuables/foods/cake.tscn"
		}, 
	"Box": {
		"value": 2,
		"drop_chance": 1.0,
		"packed_scene" : "res://src/valuables/boxes/box.tscn"
		}, 
	"Crate": {
		"value": 5,
		"drop_chance": 0.5,
		"packed_scene" : "res://src/valuables/boxes/crate.tscn"
		}, 
	"GoldenCrate": {
		"value": 10,
		"drop_chance": 0.3,
		"packed_scene" : "res://src/valuables/boxes/golden_crate.tscn"
		},
}

func get_value(type) -> int:
	return drops[type]["value"]


func get_drop_by_chance(random_value: float) -> Valuable:
	var dropped_node = null
	for key in drops.keys():
		if random_value < drops[key].drop_chance:
			dropped_node =  drops[key].packed_scene
	
	if dropped_node == null:
		push_error("No valid drop for rnd_value = %s" % random_value)
	var instance = load(dropped_node).instantiate()
	return instance
