extends Control
class_name PlayerHUD

const BULLET_SCENE = preload("res://Scenes/Entities/Player/HUD/BulletTexture.tscn")

## PlayerHUD Bullet Container
@onready var BulletContainer: HBoxContainer = $Front/H/PlayerStats/Ammo/H
## PlayerHUD Score Label
@onready var ScoreLabel: Control = $Front/H/GameStats/Score/Label
## PlayerHUD Health Bar
@onready var HealthBar: TextureProgressBar = $Front/H/PlayerStats/Health/HealthBar


## Reference to the player object
var player: Player

## Set the player for the HUD.
## Parameter _player: The player object.
func set_player(_player: Player) -> void:
	player = _player

## Update the HUD elements.
func update_ui() -> void:
	ScoreLabel.text = "Score: " + str(player.score)
	HealthBar.value = player.health
	_update_bullet_texture()

## Update the bullet textures in the HUD based on the player's bullet count.
func _update_bullet_texture() -> void:
	while BulletContainer.get_children().size() < player.bulletCount:
		BulletContainer.add_child(BULLET_SCENE.instantiate())
	while BulletContainer.get_children().size() > player.bulletCount:
		var bulletTextures: Array[Node] = BulletContainer.get_children()
		var bulletToRemove: Node = bulletTextures[bulletTextures.size() - 1]
		BulletContainer.remove_child(bulletToRemove)
		bulletToRemove.queue_free()
