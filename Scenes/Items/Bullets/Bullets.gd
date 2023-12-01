extends ItemBase


func _ready():
	item_name = "bullets"
	start_tween()


func _on_area_2d_body_entered(body) -> void:
	if body is Player:
		body.add_bullets(3)
		queue_free()
