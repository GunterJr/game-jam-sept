extends Button

func _on_button_down() -> void:
	ShopMaster.time_to_shop = false
	#print(str(ShopMaster.time_to_shop))
