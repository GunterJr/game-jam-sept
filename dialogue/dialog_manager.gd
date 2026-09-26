## Class for interacting with the dialog system. Handles reading from
## JSON files and displaying strings to the GUI.
class_name DialogManager
extends Node



@export_file_path var json_path: String

@export_category("Text Speeds")
@export var char_wait_seconds: float = 0.1
# @export var line_wait_seconds: float = 1.0

var json_out: Array

@onready var textbox: RichTextLabel = %Textbox

## Parse a JSON file and call print_dialog on each dictionary
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
		await print_dialog(dict.get("text"))

## Animate the text onto the textbox and wait for user input
func print_dialog(dialog: String) -> void:

	textbox.visible_characters = 0
	textbox.text = dialog

	for c in range(0, dialog.length()):
		textbox.visible_characters += 1
		await get_tree().create_timer(char_wait_seconds).timeout

	# await get_tree().create_timer(line_wait_seconds).timeout
	while !Input.is_action_just_pressed("ui_accept"):
		await get_tree().process_frame
