extends Node2D

@export var moveSpeed: float
@export var maxDistance: float

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up") and position.y > -maxDistance:
		position.y -= moveSpeed * delta
	if Input.is_action_pressed("ui_down") and position.y < maxDistance:
		position.y += moveSpeed * delta
