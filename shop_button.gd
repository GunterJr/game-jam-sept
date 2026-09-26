extends Button

@export var cost: int
@export var item_name: String
@export var button_focus: bool = false

func _ready():
	if button_focus == true:
		self.grab_focus()

func _on_button_down() -> void:
	if ShopMaster.time_to_shop == true:
		ShopMaster.shop_button_pressed(item_name, cost)
