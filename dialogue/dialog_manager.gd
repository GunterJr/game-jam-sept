## Class for interacting with the dialog system. Handles reading from
## JSON files and displaying strings to the GUI.
class_name DialogManager
extends Node

@export var json_path: String
var text: String
var json_out: Array

@onready var textbox: RichTextLabel = %Textbox

func _ready() -> void:
	load_dialog()

func load_dialog() -> void:
	var file := FileAccess.open(json_path, FileAccess.READ)
	if file == null:
		print("ERROR: No JSON file found.")
		return
	var json_text: String = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(json_text)
	if error == OK:
		var data_recieved = json.data
		if typeof(data_recieved) != TYPE_ARRAY:
			print("Unexpected data in JSON")
			return
		else: json_out = data_recieved
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_text, \
			" at line ", json.get_error_line())
		return

	for dict: Dictionary in json_out:
		print(dict.get("text"))
		# temporary
		# TODO: send this to the GUI
