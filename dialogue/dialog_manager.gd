## Class for interacting with the dialog system. Handles reading from
## JSON files and displaying strings to the GUI.
class_name DialogManager
extends Node

@export_file_path var json_path: String
@export var character_textures: Array[Texture2D]

@export_category("Text Speeds")
@export var char_wait_seconds: float = 0.02
# @export var line_wait_seconds: float = 1.0

var json_out: Array
var char_hide_override: bool = false

@onready var textbox: RichTextLabel = %Textbox
@onready var panel: PanelContainer = $Panel
@onready var char_name_box: Label = $Panel/MarginContainer/HBoxContainer/CharName
@onready var portrait: TextureRect = $Portrait

enum Characters {MC, BROKER, BUM}

## Parse a JSON file (convo) and call print_dialog on each dictionary
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
		if dict.get("hide_mode") != null:
			char_hide_override = dict.get("hide_mode")
			print(char_hide_override)
		await print_dialog(dict.get("text"), dict.get("name"))

	panel.visible = false
	portrait.visible = false

## Animate the text onto the textbox and wait for user input
func print_dialog(dialog: String, char_name: String) -> void:
	panel.visible = true
	portrait.visible = !char_hide_override

	textbox.visible_characters = 0
	textbox.text = dialog
	char_name_box.text = char_name

	if char_name == "MC":
		portrait.texture = character_textures[Characters.MC]
	elif char_name == "Broker":
		portrait.texture = character_textures[Characters.BROKER]
	elif char_name == "Bum":
		portrait.texture = character_textures[Characters.BUM]
	else:
		portrait.visible = false

	for c in range(0, dialog.length()):
		textbox.visible_characters += 1
		await get_tree().create_timer(char_wait_seconds).timeout

	# await get_tree().create_timer(line_wait_seconds).timeout
	while !Input.is_action_just_pressed("ui_accept"):
		await get_tree().process_frame
