extends Control
class_name PlayerHUD

const BULLET_SCENE = preload("res://Scenes/Entities/Player/HUD/BulletTexture.tscn")

@onready var BulletContainer: HBoxContainer = $Front/H/PlayerStats/Ammo/H
@onready var ScoreLabel: Control = $Front/H/GameStats/Score/Label
@onready var HealthBar: TextureProgressBar = $Front/H/PlayerStats/Health/HealthBar

var player: Player


func set_player(_player: Player) -> void:
	player = _player


func update_ui() -> void:
	ScoreLabel.text = "Score: " + str(player.score)
	HealthBar.value = player.health
	_update_bullet_texture()


func _update_bullet_texture() -> void:
	while BulletContainer.get_children().size() < player.bulletCount:
		BulletContainer.add_child(BULLET_SCENE.instantiate())
	while BulletContainer.get_children().size() > player.bulletCount:
		var bulletTextures: Array[Node] = BulletContainer.get_children()
		var bulletToRemove: Node = bulletTextures[bulletTextures.size() - 1]
		BulletContainer.remove_child(bulletToRemove)
		bulletToRemove.queue_free()
