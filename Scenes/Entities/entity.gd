extends CharacterBody2D
class_name Entity

var maxHealth: int = 100
var health: int = 100
var gravityWorks: bool = true


func _physics_process(_delta: float) -> void:
	for i in get_slide_collision_count():
		var collidedObject = get_slide_collision(i)
		if collidedObject.get_collider() is EnviromentEntity:
			process_interaction_with_movable(collidedObject)


func process_interaction_with_movable(movable: KinematicCollision2D):
	var collidedObjectSpeed = movable.get_collider().speed
	if collidedObjectSpeed >= 250:
		take_damage(
			collidedObjectSpeed / 10 * movable.get_collider().mass,
			movable.get_collider().global_position
		)
	movable.get_collider().apply_central_impulse(-movable.get_normal() * (abs(velocity.x) / 2))


func add_health(amount: int) -> void:
	health = clampi(health + amount, 0, maxHealth)


func take_damage(amount: int, _objectPosition: Vector2) -> void:
	health = clampi(health - amount, 0, maxHealth)


func calc_stagger_direction(enemyPosition: Vector2) -> Vector2:
	if global_position.x - enemyPosition.x >= 0:
		return Vector2.RIGHT
	return Vector2.LEFT


func simulate_gravity() -> void:
	if is_on_floor() or not gravityWorks:
		return
	velocity.y += Globals.World.GRAVITY
