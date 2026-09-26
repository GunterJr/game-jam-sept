extends Node2D
class_name BallDropper

@export var oscAmount: float
@export var dropHeight: float
@export var pachinkoBall: PackedScene

var time = 0

var pachinkoBallsCount = 5

func _process(delta: float) -> void:
	time += delta
	position = Vector2(sin(time) * oscAmount, dropHeight)
	$"../BallCount".text = "Balls: " + str(pachinkoBallsCount)

func _input(event: InputEvent) -> void:
	# Check for specific action events
	if event.is_action_pressed("ui_accept") && pachinkoBallsCount > 0:
		pachinkoBallsCount -= 1
		var ball = pachinkoBall.instantiate();
		get_tree().root.add_child(ball)
		ball.ballDropper = self
		ball.position = position
