extends RigidBody2D
class_name PachinkoBall

@export var fallingGravity: float
var ballDropper : BallDropper

@onready var hit: AudioStreamPlayer2D = $Hit

var isInHole: bool = false
var holePosition: Vector2

func _ready():
	angular_velocity = randf_range(-5.0, 5.0)
	gravity_scale = fallingGravity

func _process(delta: float) -> void:
	if (isInHole):
		global_position = global_position.lerp(holePosition, 5 * delta)
		$Sprite2D.scale = $Sprite2D.scale.lerp(Vector2.ZERO, 5 * delta)
		if ($Sprite2D.scale.is_equal_approx(Vector2.ZERO) or $Sprite2D.scale.length() < 0.01):
			queue_free()

func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		ballDropper.ball_not_active()

func _on_body_entered(body: Node) -> void:
	hit.play()
