extends Button

func _ready():
	self.grab_focus()

func _on_button_down() -> void:
	get_tree().change_scene_to_file("res://game_manager.tscn")
