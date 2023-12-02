extends ItemBase


func _ready():
	item_name = "heart"


func _on_area_2d_body_entered(body) -> void:
	if body is Player:
		body.add_health(10)
		queue_free()
