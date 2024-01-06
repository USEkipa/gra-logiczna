extends UpgradeItemBase

## Called every time the node is added to the scene.
func _ready():
	item_name = "increasing_ammo_limit"

## Called when a body enters the 2D area.
func _on_area_2d_body_entered(body):
	if "add_interaction" in body:
		body.add_interaction(self)

## Called when a body exits the 2D area.
func _on_area_2d_body_exited(body):
	if "erase_interaction" in body:
		body.erase_interaction(self)

## Called when the interaction is executed by a Player.
func on_execute_interaction(_player):
	_player.maxBulletCount += 3
	queue_free()
