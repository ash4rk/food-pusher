extends ColorRect

# Game Nodes (dirty refference getters)
@onready var thrower: Node3D = $"../../../World/Thrower"
@onready var carousel: Node3D = $"../../../World/Carousel"

# Debug Nodes
@onready var give_throws_btn: Button = $VBox/GiveThrowsBtn
@onready var respawn_btn: Button = $VBox/RespawnBtn
@onready var machine_gun_mode_chbx: CheckButton = $VBox/MachineGunModeChbx

var _is_machine_gun_enabled: bool = false

func _ready() -> void:
	give_throws_btn.pressed.connect(_on_give_throws_btn_pressed)
	respawn_btn.pressed.connect(_on_respawn_btn_pressed)
	machine_gun_mode_chbx.toggled.connect(_on_machine_gun_mode_toggled)

func _process(delta: float) -> void:
	if _is_machine_gun_enabled:
		thrower.throw(thrower._food_in_holder)
		thrower._food_in_holder = thrower._create_random_food()

func _input(event: InputEvent) -> void:
	if event.is_pressed() and Input.is_physical_key_pressed(KEY_W):
		self.visible = !self.visible

func _on_give_throws_btn_pressed():
	EventBus.emit_signal("on_remaining_throws_changed", 100)

func _on_respawn_btn_pressed():
	carousel.respawn_enemies()

func _on_machine_gun_mode_toggled(toggled_on: bool):
	_is_machine_gun_enabled = toggled_on
