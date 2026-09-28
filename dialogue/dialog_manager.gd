## Class for interacting with the dialog system. Handles reading from
## JSON files and displaying strings to the GUI.
class_name DialogManager
extends Node

@export_file_path var json_path: String
@export var character_textures: Array[Texture2D]
@export var bg_textures: Array[Texture2D]
@export var mc_expressions: Array[Texture2D]
@export var shark_expressions: Array[Texture2D]
@export var oldlady_expressions: Array[Texture2D]
@export var bum_expressions: Array[Texture2D]

@export_category("Text Speeds")
@export var char_wait_seconds: float = 0.02
# @export var line_wait_seconds: float = 1.0

var json_out: Array
var char_hide_override: bool = false
var curr_expression: int = 0

@onready var textbox: RichTextLabel = %Textbox
@onready var panel: PanelContainer = $Panel
@onready var char_name_box: Label = $Panel/MarginContainer/HBoxContainer/CharName
@onready var portrait: TextureRect = $Portrait
@onready var blipper: AudioStreamPlayer = $Blipper
@onready var bg: TextureRect = $BG

enum Characters {MC, BROKER, BUM}
var expression_dict: Dictionary = {
	"Default" : 0,
	"Happy"   : 1,
	"Nervous" : 2,
	"Panic1"  : 3,
	"Panic2"  : 4,
	"Empty"   : 5,
	"Broken"  : 6,
}
var expression_dict_shark: Dictionary = {
	"Default" : 0,
	"Delighted"   : 1,
	"Smug" : 2
}
var expression_dict_oldlady: Dictionary = {
	"Default" : 0,
	"Arrogant"   : 1
}
var expression_dict_bum: Dictionary = {
	"Default" : 0,
	"in the alley"   : 1,
	"Intro" : 2
}

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
		if dict.get("expression") != null:
			var exp_desc: String = dict.get("expression")
			if dict.get("name") == "Maneki":
				curr_expression = expression_dict.get(exp_desc)
			if dict.get("name") == "Samejima" || dict.get("name") == "Attendant":
				curr_expression = expression_dict_shark.get(exp_desc)
			if dict.get("name") == "Old Woman":
				curr_expression = expression_dict_oldlady.get(exp_desc)
			if dict.get("name") == "Bum":
				curr_expression = expression_dict_bum.get(exp_desc)
		else:
			curr_expression = 0
		if dict.get("bgIndex") != null:
			bg.texture = bg_textures[dict.get("bgIndex")]
		await print_dialog(dict.get("text"), dict.get("name"))

	panel.visible = false
	portrait.visible = false

## Animate the text onto the textbox and wait for user input
## expression is not passed as an argument!!!
func print_dialog(dialog: String, char_name: String) -> void:
	panel.visible = true
	portrait.visible = true

	textbox.visible_characters = 0
	textbox.text = dialog
	char_name_box.text = char_name

	if char_name == "":
		portrait.visible = false
	elif char_name == "Maneki":
		portrait.texture = mc_expressions[curr_expression]
	elif char_name == "Samejima" || char_name == "Attendant":
		portrait.texture = shark_expressions[curr_expression]
	elif char_name == "Old Woman":
		portrait.texture = oldlady_expressions[curr_expression]
	elif char_name == "Bum":
		portrait.texture = bum_expressions[curr_expression]
	else:
		portrait.visible = false

	await get_tree().process_frame

	for c in range(0, dialog.length()):
		textbox.visible_characters += 1
		blipper.play()
		if Input.is_action_pressed("ui_accept") && textbox.visible_characters > 8: break
		await get_tree().create_timer(char_wait_seconds).timeout

	textbox.visible_characters = -1
	await get_tree().process_frame
	while !Input.is_action_just_pressed("ui_accept"):
		await get_tree().process_frame
