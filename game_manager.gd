class_name GameManager
extends Node

@onready var dialogMgr: DialogManager = $DialogManager

var board: Node2D

var money: int = 0
var day: int = 1

func _ready() -> void:
	start()

func start() -> void:
	match day:
		1:
			print("Start day 1")
			dialogMgr.json_path = "res://dialogue/strings/day1/start.json"
			dialogMgr.char_hide_override = true
			await dialogMgr.load_dialog()
			board = preload("res://board/scenes/board.tscn").instantiate()
			add_child(board)
			board.get_node("BallDropper").out_of_balls.connect(new_day)
		2:
			print("Start day 2")
			dialogMgr.json_path = "res://dialogue/strings/day2/start.json"
			await dialogMgr.load_dialog()
			board = preload("res://board/scenes/board.tscn").instantiate()
			add_child(board)
			board.get_node("BallDropper").out_of_balls.connect(new_day)
		3:
			print("Start day 3")
			dialogMgr.json_path = "res://dialogue/strings/day3/start.json"
			await dialogMgr.load_dialog()
			board = preload("res://board/scenes/board.tscn").instantiate()
			add_child(board)
			board.get_node("BallDropper").out_of_balls.connect(new_day)
		_:
			pass

func new_day() -> void:
	board.queue_free()
	dialogMgr.json_path = "res://dialogue/strings/day1/end.json"
	await dialogMgr.load_dialog()
	day += 1
	start()
