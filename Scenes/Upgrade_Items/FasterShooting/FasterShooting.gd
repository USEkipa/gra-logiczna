extends UpgradeItemBase


func _ready():
	item_name = "faster_shooting"


func _on_area_2d_body_entered(body):
	if "add_interaction" in body:
		body.add_interaction(self)


func _on_area_2d_body_exited(body):
	if "erase_interaction" in body:
		body.erase_interaction(self)

func on_execute_interaction(player: Player):
	if "change_bullet_timer_speed" in player:
		player.change_bullet_timer_speed(-0.1)
	queue_free()
