extends Control

const BULLET_SCENE = preload("res://Scenes/UI/HUD/BulletTexture.tscn")

@onready var BulletContainer: HBoxContainer = $Front/H/PlayerStats/Ammo/H
@onready var ScoreLabel: Control = $Front/H/GameStats/Score/Label
@onready var HealthBar: TextureProgressBar = $Front/H/PlayerStats/Health/HealthBar


func _ready() -> void:
	add_health(Globals.PlayerStats.maxHealth)
	add_score(0)
	set_bullet_count(3)


func set_bullet_count(count: int) -> void:
	count = clamp(count, 0, Globals.PlayerStats.maxBulletCount)
	Globals.PlayerStats.bulletCount = count
	_update_bullet_texture()


func add_bullet() -> bool:
	if Globals.PlayerStats.bulletCount + 1 > Globals.PlayerStats.maxBulletCount:
		return false

	Globals.PlayerStats.bulletCount += 1
	_update_bullet_texture()
	return true


func remove_bullet() -> bool:
	if Globals.PlayerStats.bulletCount - 1 < 0:
		return false

	Globals.PlayerStats.bulletCount -= 1
	_update_bullet_texture()
	return true


func add_score(amount: int) -> void:
	Globals.PlayerStats.score += amount
	ScoreLabel.text = "Score: " + str(Globals.PlayerStats.score)


func add_health(amount: int) -> int:
	Globals.PlayerStats.health = clampi(Globals.PlayerStats.health + amount, 0, Globals.PlayerStats.maxHealth)
	HealthBar.value = Globals.PlayerStats.health
	return Globals.PlayerStats.health


func _update_bullet_texture() -> void:
	while BulletContainer.get_children().size() < Globals.PlayerStats.bulletCount:
		BulletContainer.add_child(BULLET_SCENE.instantiate())
	while BulletContainer.get_children().size() > Globals.PlayerStats.bulletCount:
		var bulletTextures: Array[Node] = BulletContainer.get_children()
		var bulletToRemove: Node = bulletTextures[bulletTextures.size() - 1]
		BulletContainer.remove_child(bulletToRemove)
		bulletToRemove.queue_free()


func _input(_event: InputEvent) -> void:
	# DEBUG
	if Input.is_key_pressed(KEY_1):
		print("add bullet: ", add_bullet())
	elif Input.is_key_pressed(KEY_2):
		print("remove bullet: ", remove_bullet())
	elif Input.is_key_pressed(KEY_3):
		print("add 10 Globals.PlayerStats.health: ", add_health(10))
	elif Input.is_key_pressed(KEY_4):
		print("remove 10 Globals.PlayerStats.health: ", add_health(-10))
	elif Input.is_key_pressed(KEY_5):
		add_score(1)
		print("add 1 Globals.PlayerStats.score: " + str(Globals.PlayerStats.score))
