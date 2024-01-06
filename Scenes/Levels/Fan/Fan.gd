extends Node2D

## An emitted signal representing the wind event.
signal wind

## A constant representing the maximum wind speed, set to 100.
const MAX_WIND_SPEED = 100

## An integer representing the base wind strength derived from the global gravity in the game.
var baseWindStrenght: int = Globals.World.GRAVITY
## An exported variable representing the current wind strength.
@export var windStrength: int = 10
## An AnimationPlayer node responsible for playing animations.
var animation_player: AnimationPlayer
## An array storing CharacterBody2D objects within the wind fan area.
var characterBodiesInFanArea: Array[CharacterBody2D] = []
## An array storing RigidBody2D objects within the wind fan area.
var rigidBodiesInFanArea: Array[RigidBody2D] = []
## A Vector2 representing the direction of the wind.
var direction: Vector2


##  Called when the scene is ready. Initializes the AnimationPlayer and calculates the direction of the wind.
func _ready() -> void:
	animation_player = $fan/AnimationPlayer
	animation_player.play("active")

	direction = (
		Vector2(cos(deg_to_rad(rotation_degrees)), sin(deg_to_rad(rotation_degrees))).normalized()
	)


## Called every physics frame. Applies wind force to character bodies and rigid bodies within the fan area.
func _physics_process(_delta) -> void:
	for body in characterBodiesInFanArea:
		body.velocity += direction * get_wind_strenght()

	for body in rigidBodiesInFanArea:
		body.apply_central_impulse(direction * get_wind_strenght())


## Signal callback when a body enters the wind fan area.
func _on_wind_body_entered(body) -> void:
	if body is CharacterBody2D:
		characterBodiesInFanArea.append(body)
	if body is RigidBody2D:
		rigidBodiesInFanArea.append(body)


## Signal callback when a body exits the wind fan area.
func _on_wind_body_exited(body) -> void:
	if body is CharacterBody2D:
		characterBodiesInFanArea.remove_at(characterBodiesInFanArea.find(body))
	if body is RigidBody2D:
		rigidBodiesInFanArea.remove_at(rigidBodiesInFanArea.find(body))


## Returns the current wind strength, combining the base wind strength and the exported wind strength.
func get_wind_strenght() -> int:
	return windStrength + baseWindStrenght
