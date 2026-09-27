extends Node2D
class_name BallDropper

@export var oscAmount: float
@export var dropHeight: float
@export var pachinkoBall: PackedScene

var time = 0
@export var pachinkoBallsCount = 5
var isBallActive: bool = false

var drinks: Array[powerup]

func _process(delta: float) -> void:
	time += delta
	position = Vector2(sin(time) * oscAmount, dropHeight)
	$"../CameraController/BallCount".text = "Balls: " + str(pachinkoBallsCount)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drop_ball") && pachinkoBallsCount > 0 && !isBallActive && ShopMaster.time_to_shop == false:
		pachinkoBallsCount -= 1
		var ball = pachinkoBall.instantiate();
		get_tree().root.add_child(ball)
		ball.ballDropper = self
		ball.position = position
		
		# apply powerups
		for drink in drinks:
			(ball as RigidBody2D).physics_material_override.bounce += drink.bouncinessModifier;
			(ball as RigidBody2D).mass += drink.heavinessModifier;
			drink.turnsLeft -= 1;
		
		isBallActive = true

func ball_not_active() -> void:
	isBallActive = false

func add_ball_count(count: int) -> void:
	var scoreMult = 1
	for drink in drinks:
		scoreMult += drink.scoreModifier
	pachinkoBallsCount += count * scoreMult;

func addPowerup(turnsLeft: int, bouncinessModifier: float, heavinessModifier: float, scoreModifier: int):
	var newDrink = powerup.new();
	newDrink.turnsLeft = turnsLeft;
	newDrink.bouncinessModifier = bouncinessModifier;
	newDrink.heavinessModifier = heavinessModifier;
	newDrink.scoreModifier = scoreModifier;
	drinks.append(newDrink);

class powerup:
	var turnsLeft
	var bouncinessModifier: float = 0
	var heavinessModifier: float = 0
	var scoreModifier: int = 1
