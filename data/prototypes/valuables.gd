extends Resource
class_name ValuablesData

@export_category("Ticket Value")
@export var drops: Dictionary = {
	"Food (aka coin)": 50, 
	"Box": 75, 
	"Crate": 100,
	"GoldenCrate": 100
}

func get_value(type):
	return drops[type]
