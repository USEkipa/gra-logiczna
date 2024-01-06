extends Node2D

## Constants:
##- **BULLET_SCENE**: A constant PackedScene representing the PlayerBullet scene, preloaded for efficient instantiation.
const BULLET_SCENE: PackedScene = preload(
	"res://Scenes/Entities/Player/Projectiles/PlayerBullet.tscn"
)

##- **player**: A reference to the Player node.
@onready var player: Player = $Player
##- **projectiles**: A Node2D used to group and manage player bullets.
var projectiles: Node2D = null

## Function: `_ready()`
##- **Description**: Called when the scene is ready. Initializes the projectiles node and connects the "bullet_shot" signal from the player.
##- **Actions**:
##  - Creates a new Node2D instance named "Projectiles" and adds it as a child.
##  - Connects the "bullet_shot" signal to the `bullet_shot` function.
func _ready() -> void:
	projectiles = Node2D.new()
	projectiles.name = "Projectiles"
	add_child(projectiles, true)
	player.connect("bullet_shot", bullet_shot)

## Function: `bullet_shot(pos: Vector2, direction: Vector2)`
##- **Description**: Handles the event when the player shoots a bullet.
##- **Parameters**:
##  - `pos`: The position where the bullet is shot.
##  - `direction`: The direction in which the bullet is shot.
##- **Actions**:
##  - Instantiates a new player bullet from the preloaded scene.
##  - Sets the rotation and direction of the bullet.
##  - Sets the position of the bullet.
##  - Adds the bullet as a child to the "Projectiles" node.
func bullet_shot(pos: Vector2, direction: Vector2) -> void:
	var bullet = BULLET_SCENE.instantiate()
	bullet.rotation = direction.angle()
	bullet.direction = direction
	bullet.position = pos
	projectiles.add_child(bullet)
