extends Button

@export var cost: int
@export var item_name: String
@export var button_focus: bool = false

@export var switchShop: switch_shop

func _ready():
	if button_focus == true:
		self.grab_focus()

func _on_button_down() -> void:
	if ShopMaster.time_to_shop == true:
		switchShop.auto_button_engage(cost)
