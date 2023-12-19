extends Node2D

### Signal:
- **wind**: An emitted signal representing the wind event.
signal wind

### Constants:
- **MAX_WIND_SPEED**: A constant representing the maximum wind speed, set to 100.
const MAX_WIND_SPEED = 100

### Variables:
- **baseWindStrenght**: An integer representing the base wind strength derived from the global gravity in the game.
- **windStrength**: An exported variable representing the current wind strength.
- **animation_player**: An AnimationPlayer node responsible for playing animations.
- **characterBodiesInFanArea**: An array storing CharacterBody2D objects within the wind fan area.
- **rigidBodiesInFanArea**: An array storing RigidBody2D objects within the wind fan area.
- **direction**: A Vector2 representing the direction of the wind.
var baseWindStrenght: int = Globals.World.GRAVITY
@export var windStrength: int = 10
var animation_player: AnimationPlayer
var characterBodiesInFanArea: Array[CharacterBody2D] = []
var rigidBodiesInFanArea: Array[RigidBody2D] = []
var direction: Vector2

### Function: `_ready()`
- **Description**: Called when the scene is ready. Initializes the AnimationPlayer and calculates the direction of the wind.
- **Actions**:
  - Sets up the animation player to play the "active" animation.
  - Calculates the direction based on the rotation of the wind fan.
func _ready() -> void:
	animation_player = $fan/AnimationPlayer
	animation_player.play("active")

	direction = (
		Vector2(cos(deg_to_rad(rotation_degrees)), sin(deg_to_rad(rotation_degrees))).normalized()
	)

### Function: `_physics_process(_delta)`
- **Description**: Called every physics frame. Applies wind force to character bodies and rigid bodies within the fan area.
- **Parameters**:
  - `_delta`: The time elapsed since the last frame.
- **Actions**:
  - Iterates over character bodies in the fan area, applying wind force.
  - Iterates over rigid bodies in the fan area, applying central impulse.
func _physics_process(_delta) -> void:
	for body in characterBodiesInFanArea:
		body.velocity += direction * get_wind_strenght()

	for body in rigidBodiesInFanArea:
		body.apply_central_impulse(direction * get_wind_strenght())

### Function: `_on_wind_body_entered(body)`
- **Description**: Signal callback when a body enters the wind fan area.
- **Parameters**:
  - `body`: The body that entered the fan area.
- **Actions**:
  - Appends character bodies and rigid bodies to their respective arrays.
func _on_wind_body_entered(body) -> void:
	if body is CharacterBody2D:
		characterBodiesInFanArea.append(body)
	if body is RigidBody2D:
		rigidBodiesInFanArea.append(body)

### Function: `_on_wind_body_exited(body)`
- **Description**: Signal callback when a body exits the wind fan area.
- **Parameters**:
  - `body`: The body that exited the fan area.
- **Actions**:
  - Removes character bodies and rigid bodies from their respective arrays.
func _on_wind_body_exited(body) -> void:
	if body is CharacterBody2D:
		characterBodiesInFanArea.remove_at(characterBodiesInFanArea.find(body))
	if body is RigidBody2D:
		rigidBodiesInFanArea.remove_at(rigidBodiesInFanArea.find(body))

### Function: `get_wind_strength()`
- **Description**: Returns the current wind strength, combining the base wind strength and the exported wind strength.
- **Returns**:
  - An integer representing the combined wind strength.
func get_wind_strenght() -> int:
	return windStrength + baseWindStrenght