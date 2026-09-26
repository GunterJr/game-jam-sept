extends Node2D

var time_to_shop: bool = false

func shop_button_pressed(name: String, cost: int):
	print(name + " was pressed!")
	print("the cost of this purchase was " + str(cost) + " dollars.")
	
