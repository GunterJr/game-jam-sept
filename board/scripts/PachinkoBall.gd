extends RigidBody2D
class_name PachinkoBall

@export var fallingGravity: float
var ballDropper : BallDropper

func _ready():
	angular_velocity = randf_range(-5.0, 5.0)
	gravity_scale = fallingGravity

func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		ballDropper.ball_not_active()
