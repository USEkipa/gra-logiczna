extends ItemBase


func _ready():
	item_name = "coin"


func _on_area_2d_body_entered(body) -> void:
	if body is Player:
		body.add_score(1)
		queue_free()
