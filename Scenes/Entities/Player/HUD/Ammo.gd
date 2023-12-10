extends MarginContainer

const BULLET_SCENE = preload("res://Scenes/Entities/Player/HUD/BulletTexture.tscn")
const MAX_BULLET_COUNT = 10
@onready var BulletContainer: HBoxContainer = $H

var bulletCount: int = 0


func add_bullet() -> bool:
	if bulletCount + 1 > MAX_BULLET_COUNT:
		return false

	bulletCount += 1
	_update_bullet_texture()
	return true


func remove_bullet() -> bool:
	if bulletCount - 1 < 0:
		return false

	bulletCount -= 1
	_update_bullet_texture()
	return true


func _update_bullet_texture():
	var bulletTextures: Array[Node] = BulletContainer.get_children()

	if bulletTextures.size() < bulletCount:
		BulletContainer.add_child(BULLET_SCENE.instantiate())
	if bulletTextures.size() > bulletCount:
		bulletTextures[bulletTextures.size() - 1].queue_free()


func _input(_event: InputEvent) -> void:
	# DEBUG
	if Input.is_key_pressed(KEY_0):
		print("add bullet: ", add_bullet())
	if Input.is_key_pressed(KEY_1):
		print("remove bullet: ", remove_bullet())
