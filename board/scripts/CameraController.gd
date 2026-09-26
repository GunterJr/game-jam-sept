extends Node2D

@export var moveSpeed: float
@export var maxDistance: float

func _process(delta: float) -> void:
	$UpArrow.visible = position.y > -maxDistance
	$DownArrow.visible = position.y < maxDistance;
	
	if (Input.is_action_pressed("ui_up") && position.y > -maxDistance):
		position.y -= moveSpeed * delta
	if Input.is_action_pressed("ui_down") && position.y < maxDistance:
		position.y += moveSpeed * delta
