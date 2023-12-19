extends Area2D

@export var jumpStrength := -400
var animationPlayer: AnimationPlayer

func _ready():
	animationPlayer = $AnimationPlayer

### Function: `_on_body_entered(body: Node2D) -> void`
- **Description**: Callback function triggered when a body enters the area.
- **Parameters**:
  - `body`: The Node2D object representing the entering body.
- **Actions**:
  - Calls `characterBody2D_accelerate_up(body)` if the entering body is of type Entity.
  - Calls `rigidBody2D_accelerate_up(body)` if the entering body is of type EnviromentEntity.
func _on_body_entered(body: Node2D) -> void:
	if body is Entity:
		characterBody2D_accelerate_up(body)
	if body is EnviromentEntity:
		rigidBody2D_accelerate_up(body)

### Function: `characterBody2D_accelerate_up(body: CharacterBody2D)`
- **Description**: Accelerates the provided CharacterBody2D upward and plays the "active" animation.
- **Parameters**:
  - `body`: The CharacterBody2D object to be accelerated.
- **Actions**:
  - Plays the "active" animation using the AnimationPlayer.
  - Sets the y-velocity of the CharacterBody2D to the defined `jumpStrength`.
func characterBody2D_accelerate_up(body: CharacterBody2D):
	animationPlayer.play("active")
	body.velocity.y = jumpStrength

### Function: `rigidBody2D_accelerate_up(body: RigidBody2D)`
- **Description**: Accelerates the provided RigidBody2D downward and plays the "active" animation.
- **Parameters**:
  - `body`: The RigidBody2D object to be accelerated.
- **Actions**:
  - Plays the "active" animation using the AnimationPlayer.
  - Applies a central impulse in the downward direction scaled by the `jumpStrength` to the RigidBody2D.
func rigidBody2D_accelerate_up(body: RigidBody2D):
	animationPlayer.play("active")
	body.apply_central_impulse(Vector2.DOWN * jumpStrength)
