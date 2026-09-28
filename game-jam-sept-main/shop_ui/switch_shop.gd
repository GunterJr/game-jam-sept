extends Control
class_name switch_shop

@export var shop_pos: float
@export var down_pos: float
@export var switch_speed: float
@export var ballDropper: BallDropper

func _process(delta):
	if ShopMaster.time_to_shop == false:
		if self.global_position.y < down_pos:
			self.global_position.y += switch_speed
	elif ShopMaster.time_to_shop == true:
		if self.global_position.y > shop_pos:
			self.global_position.y -= switch_speed
	
	if Input.is_action_just_pressed("shop_button"):
		ShopMaster.time_to_shop = true
		#print(str(ShopMaster.time_to_shop))

func shop_button_pressed(name: String, cost: int, turnsLeft: int, bouncinessModifier: float, heavinessModifier: float, scoreModifier: int):
	ballDropper.addPowerup(turnsLeft, bouncinessModifier, heavinessModifier, scoreModifier);
	ShopMaster.shop_button_pressed(name, cost);
