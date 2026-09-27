class_name GameManager
extends Node

@onready var dialogMgr: DialogManager = $DialogManager

var money: int = 0
var day: int = 1

func _ready() -> void:
	match day:
		1:
			dialogMgr.json_path = "res://dialogue/strings/day1/start.json"
			dialogMgr.char_hide_override = true
			await dialogMgr.load_dialog()
			var board = preload("res://board/scenes/board.tscn").instantiate()
			add_child(board)
			print("Start day 1")
		2:
			print("Start day 2")
		3:
			print("State day 3")
		_:
			pass
