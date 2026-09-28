class_name GameManager
extends Node

@onready var dialogMgr: DialogManager = $DialogManager

var board: Node2D

var balls: int = 0
var day: int = 1

func _ready() -> void:
	start()

func start() -> void:
	match day:
		1:
			print("Start part 1")
			dialogMgr.json_path = "res://dialogue/strings/part1-script.json"
			await dialogMgr.load_dialog()
			board = preload("res://board/scenes/board.tscn").instantiate()
			add_child(board)
			board.get_node("BallDropper").out_of_balls.connect(subpart, 1)
			board.get_node("BallDropper").pachinkoBallsCount = balls
			if (board.get_node("BallDropper").pachinkoBallsCount == 0):
				board.get_node("BallDropper").pachinkoBallsCount += 10
		2:
			print("Start part 2")
			dialogMgr.json_path = "res://dialogue/strings/part2-script.json"
			await dialogMgr.load_dialog()
			day += 1
			start()
		3:
			print("Start part 3")
			dialogMgr.json_path = "res://dialogue/strings/part3-script.json"
			await dialogMgr.load_dialog()
			board = preload("res://board/scenes/board.tscn").instantiate()
			add_child(board)
			board.get_node("BallDropper").out_of_balls.connect(end, balls)
			board.get_node("BallDropper").pachinkoBallsCount = balls
			if (board.get_node("BallDropper").pachinkoBallsCount == 0):
				board.get_node("BallDropper").pachinkoBallsCount += 10
		4:
			print("Start part 4")
			dialogMgr.json_path = "res://dialogue/strings/part4-script.json"
			await dialogMgr.load_dialog()
			day += 1
			start()
		5:
			print("Start part 5")
			dialogMgr.json_path = "res://dialogue/strings/part5-script.json"
			await dialogMgr.load_dialog()
			board = preload("res://board/scenes/board.tscn").instantiate()
			add_child(board)
			board.get_node("BallDropper").out_of_balls.connect(subpart, 5)
			board.get_node("BallDropper").pachinkoBallsCount = balls
			if (board.get_node("BallDropper").pachinkoBallsCount == 0):
				board.get_node("BallDropper").pachinkoBallsCount += 10
		6:
			print("Start part 6")
			dialogMgr.json_path = "res://dialogue/strings/part6-script.json"
			await dialogMgr.load_dialog()
			day += 1
			start()
		7:
			print("Start part 7")
			dialogMgr.json_path = "res://dialogue/strings/part8-script.json"
			await dialogMgr.load_dialog()
			board = preload("res://board/scenes/board.tscn").instantiate()
			add_child(board)
			board.get_node("BallDropper").out_of_balls.connect(end, balls)
			board.get_node("BallDropper").pachinkoBallsCount = balls
			if (board.get_node("BallDropper").pachinkoBallsCount == 0):
				board.get_node("BallDropper").pachinkoBallsCount += 10
		8:
			get_tree().quit()

## This plays after a given main part
func subpart(part: int) -> void:
	print("Start subpart " + str(part) + ".5")
	dialogMgr.json_path = "res://dialogue/strings/part" + str(part) + ".5-script.json"
	await dialogMgr.load_dialog()
	end(board.get_node("BallDropper").pachinkoBallsCount)

func end(ballsLeft: int) -> void: #stupid
	board.queue_free()
	balls += ballsLeft
	day += 1
	start()
