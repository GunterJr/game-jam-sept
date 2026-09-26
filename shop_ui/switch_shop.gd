extends Control

@export var shop_pos: float
@export var down_pos: float
@export var shop_switch_speed: float

func _process(delta):
	if ShopMaster.time_to_shop == false:
		if self.global_position.y < down_pos:
			self.global_position.y += shop_switch_speed
	elif ShopMaster.time_to_shop == true:
		if self.global_position.y > shop_pos:
			self.global_position.y -= shop_switch_speed
	
	if Input.is_action_just_pressed("shop_button"):
		ShopMaster.time_to_shop = true
		#print(str(ShopMaster.time_to_shop))
