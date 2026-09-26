extends Node2D

func shop_button_pressed(name: String, cost: int):
	print(name + " was pressed!")
	print("the cost of this purchase was " + str(cost) + " dollars.")
