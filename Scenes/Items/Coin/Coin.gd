extends ItemBase

## Called every time the node is added to the scene.
func _ready():
	item_name = "coin"

## Called when a body enters the 2D area.
func _on_area_2d_body_entered(body) -> void:
	if body is Player:
		body.add_score(1)
		queue_free()
