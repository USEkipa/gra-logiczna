extends Node2D

const BULLET_SCENE: PackedScene = preload(
	"res://Scenes/Entities/Player/Projectiles/PlayerBullet.tscn"
)

@onready var player: Player = $Player
var projectiles: Node2D = null


func _ready() -> void:
	projectiles = Node2D.new()
	projectiles.name = "Projectiles"
	add_child(projectiles, true)
	player.connect("bullet_shot", bullet_shot)


func bullet_shot(pos: Vector2, direction: Vector2) -> void:
	var bullet = BULLET_SCENE.instantiate()
	bullet.rotation = direction.angle()
	bullet.direction = direction
	bullet.position = pos
	projectiles.add_child(bullet)
