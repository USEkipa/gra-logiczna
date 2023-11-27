extends ItemBase


func _ready():
	item_name = "bullets"
	start_tween()


func _on_area_2d_body_entered(body) -> void:
	if body is Player:
		if Globals.PlayerStats.bulletCount < Globals.PlayerStats.maxBulletCount:
			body.bullet_picked_up(Globals.PlayerStats.bulletCount + 3)
			queue_free()
