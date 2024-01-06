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


## Function changes the current state of a movable object on `idle` when ready
func _ready() -> void:
	change_state(states.idle)


## Function responsible for running different logic based on object's state.
##
## Params:
##
## `delta`: `float`		delta time since previous frame
func _physics_process(delta: float) -> void:
	match currentState:
		states.idle:
			process_idle_chipped_state(delta)
		states.chipped:
			process_idle_chipped_state(delta)
		states.destroyed:
			process_destroyed_state()


## Function containing logic for destroing the object.
##
## Function stops the angular movement of the object and awaits the end of `destroyed` animation
func process_destroyed_state() -> void:
	rotation_degrees = 0.0
	set_deferred("lock_rotation", true)
	if not animations.is_playing():
		queue_free()


## Function containing logic for `idle` and `chipped` states.
##
## Function calculates an object's linear velocity on set time intervals 
## used to calculate damage dealt to entities.
##
## Params:
##
## `delta`: `float`		delta time since previous frame
func process_idle_chipped_state(delta: float) -> void:
	remainingTime -= delta
	if remainingTime <= 0.0:
		speed = get_object_speed()
		remainingTime = velocityRefreshTime


## Function responsible for changing the object's state
##
## Based on the argument the state is changed accordingly, and specific
## to the state animation is played.
##
## Params:
##
## `newState`: `int`		enum value of the state to change to
func change_state(newState: int) -> void:
	currentState = newState
	match currentState:
		states.idle:
			animations.play("idle")
		states.chipped:
			animations.play("chipped")
		states.destroyed:
			animations.play("destroyed")


## Function calculating the linear speed of the object
##
## The speed is calculated using pitagorean formula.
##
## Return:
##
## `result`: `float`		the linear speed of the object
func get_object_speed() -> float:
	return sqrt((linear_velocity.x * linear_velocity.x) + (linear_velocity.y * linear_velocity.y))


## Function responsible for damaging the the object
##
## Function first checks if the object is in `destroyed` state, and if so it
## doesn't proceed with its logic. Otherwise the damge value is subtracted from
## the current health and if said health reaches half of max health the state is changed
## to chipped. When health reaches 0 the state is changed to `destroyed`.
##
## Params:
##
## `damage`: `int`							value that is going to be subtracted from current health
##
## `_attackSourcePosition`: `Vector2`		vector value of the damage source position
func take_damage(damage: int, _attackSourcePosition: Vector2) -> void:
	if currentState == states.destroyed:
		return
	health = clamp(health - damage, 0, maxHealth)
	if health <= maxHealth / 2:
		change_state(states.chipped)
	if health <= 0:
		change_state(states.destroyed)
