extends Node2D

@export var oscAmount: float
@export var dropHeight: float
@export var PachinkoBall: PackedScene

var time = 0

var isDropped = false

func _process(delta: float) -> void:
	if (!isDropped):
		time += delta
		position = Vector2(sin(time) * oscAmount, dropHeight)

func _input(event: InputEvent) -> void:
	# Check for specific action events
	if event.is_action_pressed("ui_accept") && !isDropped:
		# isDropped = true
		var ball = PachinkoBall.instantiate();
		get_tree().root.add_child(ball)
		ball.position = position
