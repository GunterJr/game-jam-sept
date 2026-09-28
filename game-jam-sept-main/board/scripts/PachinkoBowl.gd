extends Node2D

@export var area2D: Area2D
@export var scoreAmount: int

func _on_body_entered(body: Node2D) -> void:
	await get_tree().create_timer(0.5).timeout
	if is_instance_valid(body) && area2D.overlaps_body(body):
		(body as PachinkoBall).holePosition = position
		(body as PachinkoBall).isInHole = true
		(body as PachinkoBall).ballDropper.add_ball_count(scoreAmount)
