extends UpgradeItemBase


func _ready():
	item_name = "higher_jumps"


func _on_area_2d_body_entered(body):
	if "add_interaction" in body:
		body.add_interaction(self)


func _on_area_2d_body_exited(body):
	if "erase_interaction" in body:
		body.erase_interaction(self)

func on_execute_interaction(player):
	Globals.PlayerStats.JUMP_VELOCITY = -400
	queue_free()
