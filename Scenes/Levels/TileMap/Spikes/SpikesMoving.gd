extends Area2D

const SPIKE_DAMAGE = 100

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

enum SpikeState { UP, DOWN }

var current_state: SpikeState = SpikeState.DOWN


func _ready() -> void:
	timer.start()
	animationPlayer.play("idle")


func _on_timer_timeout() -> void:
	if current_state == SpikeState.DOWN:
		animationPlayer.play("active")
		current_state = SpikeState.UP
	else:
		animationPlayer.play("idle")
		current_state = SpikeState.DOWN
	timer.start()


func _on_body_entered(body) -> void:
	if body is Entity && current_state == SpikeState.UP:
		body.take_damage(SPIKE_DAMAGE, global_position)
