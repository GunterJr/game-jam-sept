extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.region_rect.position.x = 0
@export var pegMulti : float = 0.00
@export var sprite : Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activated():
	sprite.region_rect.position.x = 16
	pegMulti += .035
	await get_tree().create_timer(30.0).timeout
	sprite.region_rect.position.x = 0
	pegMulti += .035


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is PachinkoBall: activated()
