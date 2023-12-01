extends Area2D

@export var jumpStrength = -400
var animationPlayer: AnimationPlayer

func _ready():
	animationPlayer = $AnimationPlayer

func _on_body_entered(body:Node2D) -> void:
	if body is Player or body is EnemyBase:
		body_accelerate_up(body)

func body_accelerate_up(body:Node2D):
	animationPlayer.play("active")
	body.velocity.y = jumpStrength
