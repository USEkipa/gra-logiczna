extends Area2D

@export var jumpStrength := -400
var animationPlayer: AnimationPlayer


func _ready():
	animationPlayer = $AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	if body is Entity:
		characterBody2D_accelerate_up(body)
	if body is EnviromentEntity:
		rigidBody2D_accelerate_up(body)


func characterBody2D_accelerate_up(body: CharacterBody2D):
	animationPlayer.play("active")
	body.velocity.y = jumpStrength


func rigidBody2D_accelerate_up(body: RigidBody2D):
	animationPlayer.play("active")
	body.apply_central_impulse(Vector2.DOWN * jumpStrength)
