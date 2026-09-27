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
			print("Start day 1")
			dialogMgr.json_path = "res://dialogue/strings/part1-script.json"
			await dialogMgr.load_dialog()
			board = preload("res://board/scenes/board.tscn").instantiate()
			add_child(board)
			board.get_node("BallDropper").out_of_balls.connect(new_day)
			board.get_node("BallDropper").pachinkoBallsCount = balls
			if (board.get_node("BallDropper").pachinkoBallsCount == 0):
				board.get_node("BallDropper").pachinkoBallsCount += 10
		2:
			print("Start day 2")
			dialogMgr.json_path = "res://dialogue/strings/day2/start.json"
			await dialogMgr.load_dialog()
			board = preload("res://board/scenes/board.tscn").instantiate()
			add_child(board)
			board.get_node("BallDropper").out_of_balls.connect(new_day)
			board.get_node("BallDropper").pachinkoBallsCount = balls
			if (board.get_node("BallDropper").pachinkoBallsCount == 0):
				board.get_node("BallDropper").pachinkoBallsCount += 10
		3:
			print("Start day 3")
			dialogMgr.json_path = "res://dialogue/strings/day3/start.json"
			await dialogMgr.load_dialog()
			board = preload("res://board/scenes/board.tscn").instantiate()
			add_child(board)
			board.get_node("BallDropper").out_of_balls.connect(new_day)
			board.get_node("BallDropper").pachinkoBallsCount = balls
			if (board.get_node("BallDropper").pachinkoBallsCount == 0):
				board.get_node("BallDropper").pachinkoBallsCount += 10
		_:
			pass

func new_day(ballsLeft: int) -> void: #stupid
	board.queue_free()
	balls += ballsLeft
	dialogMgr.json_path = "res://dialogue/strings/part1.5-script.json"
	await dialogMgr.load_dialog()
	day += 1
	start()
