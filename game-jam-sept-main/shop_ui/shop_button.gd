extends Button

@export var cost: int
@export var item_name: String
@export var button_focus: bool = false

@export var turnsLeft: int
@export var bouncinessModifier: float = 0
@export var heavinessModifier: float = 0
@export var scoreModifier: int = 1

@export var switchShop: switch_shop

func _ready():
	if button_focus == true:
		self.grab_focus()

func _on_button_down() -> void:
	if ShopMaster.time_to_shop == true:
		switchShop.shop_button_pressed(item_name, cost, turnsLeft, bouncinessModifier, heavinessModifier, scoreModifier);
