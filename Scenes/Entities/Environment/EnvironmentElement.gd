extends RigidBody2D
class_name EnviromentEntity


@export
var maxHealth: float = 40.0
@onready
var animations: AnimatedSprite2D = $Animations
var health: float = maxHealth
var velocityRefreshTime: float = 0.1
var remainingTime: float = velocityRefreshTime
var speed: float = get_object_speed()
enum states {idle, chipped, destroyed}
var currentState: int


func _ready() -> void:
	change_state(states.idle)


func _physics_process(delta: float) -> void:
	match currentState:
		states.idle:
			process_idle_chipped_state(delta)
		states.chipped:
			process_idle_chipped_state(delta)
		states.destroyed:
			process_destroyed_state()


func process_destroyed_state() -> void:
	rotation_degrees = 0.0
	set_deferred("lock_rotation", true)
	if not animations.is_playing():
		queue_free()


func process_idle_chipped_state(delta: float) -> void:
	remainingTime -= delta
	if remainingTime <= 0.0:
		speed = get_object_speed()
		remainingTime = velocityRefreshTime


func change_state(newState: int) -> void:
	currentState = newState
	match currentState:
		states.idle:
			animations.play("idle")
		states.chipped:
			animations.play("chipped")
		states.destroyed:
			animations.play("destroyed")


func get_object_speed() -> float:
	return sqrt((linear_velocity.x * linear_velocity.x) + (linear_velocity.y * linear_velocity.y))


func take_damage(damage: int, _attackSourcePosition: Vector2):
	if currentState == states.destroyed:
		return
	health = clamp(health - damage, 0, maxHealth)
	if health <= maxHealth / 2:
		change_state(states.chipped)
	if health <= 0:
		change_state(states.destroyed)
