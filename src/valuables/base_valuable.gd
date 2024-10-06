extends RigidBody3D

## Base class for entities giving tickets
## Food (aka Coin), Box, Crate and Golden Crate
class_name Valuable

@export_enum("Food (aka coin)", "Box", "Crate", "GoldenCrate") var type: String

# Takes data for all inheritors from .tres
@onready var DATA_RES: Resource = load("res://data/valuables.tres")
@onready var value: int = DATA_RES.get_value(type)
