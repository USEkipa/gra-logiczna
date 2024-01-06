extends Area2D

@export var jumpStrength := -400
var animationPlayer: AnimationPlayer


func _ready():
	animationPlayer = $AnimationPlayer


## Callback function triggered when a body enters the area.
func _on_body_entered(body: Node2D) -> void:
	if body is Entity:
		characterBody2D_accelerate_up(body)
	if body is EnviromentEntity:
		rigidBody2D_accelerate_up(body)


## Accelerates the provided CharacterBody2D upward and plays the "active" animation.
func characterBody2D_accelerate_up(body: CharacterBody2D):
	animationPlayer.play("active")
	body.velocity.y = jumpStrength


## Accelerates the provided RigidBody2D downward and plays the "active" animation.
func rigidBody2D_accelerate_up(body: RigidBody2D):
	animationPlayer.play("active")
	body.apply_central_impulse(Vector2.DOWN * jumpStrength)
