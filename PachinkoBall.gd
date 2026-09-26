extends RigidBody2D

@export var fallingGravity: float

var isDropped = false

func _ready():
	angular_velocity = randf_range(-5.0, 5.0)
	gravity_scale = fallingGravity
