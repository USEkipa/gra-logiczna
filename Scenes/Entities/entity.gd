extends CharacterBody2D
class_name Entity

var maxHealth: int = 100
var health: int = 100
var gravityWorks: bool = true


func add_health(amount: int) -> void:
	health = clampi(health + amount, 0, maxHealth)


func take_damage(amount: int, _objectPosition: Vector2) -> void:
	health = clampi(health - amount, 0, maxHealth)


func calc_stagger_direction(enemyPosition: Vector2) -> Vector2:
	var dir = global_position.x - enemyPosition.x
	if dir >= 0:
		return Vector2.RIGHT
	return Vector2.LEFT


func simulate_gravity() -> void:
	if is_on_floor() or not gravityWorks:
		return
	velocity.y += Globals.World.GRAVITY
