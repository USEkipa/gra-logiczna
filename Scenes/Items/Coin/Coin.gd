extends ItemBase


func _ready():
	item_name = "coin"


func _on_area_2d_body_entered(body):
	if "increase_score_count" in body:
		body.increase_score_count(1)
		queue_free()
