extends Button

func _on_button_down() -> void:
	ShopMaster.time_to_shop = false

func _process(delta):
	if Input.is_action_just_pressed("shop_button"):
		if ShopMaster.time_to_shop == true:
			ShopMaster.time_to_shop = false
