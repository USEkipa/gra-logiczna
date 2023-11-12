extends Area2D

@export var jumpStrength = -400
var animationPlayer: AnimationPlayer

func _ready():
	animationPlayer = $AnimationPlayer

func _on_body_entered(body):
	if body is Player:
		player_jump(body)

func player_jump(player):
	animationPlayer.play("active")
	player.velocity.y = jumpStrength
