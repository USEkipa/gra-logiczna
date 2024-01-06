extends Node2D

## A constant PackedScene representing the PlayerBullet scene, preloaded for efficient instantiation.
const BULLET_SCENE: PackedScene = preload(
	"res://Scenes/Entities/Player/Projectiles/PlayerBullet.tscn"
)

## A reference to the Player node.
@onready var player: Player = $Player
## A Node2D used to group and manage player bullets.
var projectiles: Node2D = null


## Called when the scene is ready. Initializes the projectiles node and connects the "bullet_shot" signal from the player.
func _ready() -> void:
	projectiles = Node2D.new()
	projectiles.name = "Projectiles"
	add_child(projectiles, true)
	player.connect("bullet_shot", bullet_shot)


## Handles the event when the player shoots a bullet.
func bullet_shot(pos: Vector2, direction: Vector2) -> void:
	var bullet = BULLET_SCENE.instantiate()
	bullet.rotation = direction.angle()
	bullet.direction = direction
	bullet.position = pos
	projectiles.add_child(bullet)
