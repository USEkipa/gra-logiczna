extends ItemBase


func _ready():
	item_name = "heart"


func _on_area_2d_body_entered(body):
	if "increase_health_count" in body:
		if Globals.PlayerStats.health < Globals.PlayerStats.maxHealth:
			body.increase_health_count(10)
			queue_free()
