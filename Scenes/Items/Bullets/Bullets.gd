extends ItemBase


func _ready():
	item_name = "bullets"


func _on_area_2d_body_entered(body):
	if "increase_bullet_count" in body:
		if Globals.PlayerStats.bulletCount < Globals.PlayerStats.maxBulletCount:
			body.increase_bullet_count(Globals.PlayerStats.bulletCount + 3)
			queue_free()