extends Button

@export var ballDropper: BallDropper

func _on_button_down() -> void:
	ballDropper.cash_out();
