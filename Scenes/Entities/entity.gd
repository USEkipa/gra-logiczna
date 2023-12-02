extends CharacterBody2D
class_name Entity

var maxHealth: int = 100
var health: int = 100
var gravityWorks: bool = true
var pushForce := 20


func _physics_process(_delta: float) -> void:
	for i in get_slide_collision_count():
		var collided_object = get_slide_collision(i)
		if collided_object.get_collider() is RigidBody2D:
			collided_object.get_collider().apply_central_impulse(
				-collided_object.get_normal() * pushForce
			)


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
