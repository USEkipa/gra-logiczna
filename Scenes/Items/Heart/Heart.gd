extends ItemBase


func _ready():
	item_name = "heart"
	start_tween()


func _on_area_2d_body_entered(body) -> void:
	if body is Player:
		if Globals.PlayerStats.health < Globals.PlayerStats.maxHealth:
			body.health_picked_up(10)
			queue_free()
