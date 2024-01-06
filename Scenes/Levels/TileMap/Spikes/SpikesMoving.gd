extends Area2D

const SPIKE_DAMAGE = 100

## An onready variable referencing the AnimationPlayer node responsible for managing animations.
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
## An onready variable referencing the Timer node used to control spike movements.
@onready var timer: Timer = $Timer

enum SpikeState { UP, DOWN }

## Represents the current state of the spike (either UP or DOWN).
var current_state: SpikeState = SpikeState.DOWN


## Called when the scene is ready. Initializes the timer and plays the idle animation.
func _ready() -> void:
	timer.start()
	animationPlayer.play("idle")


## Callback function for the timer timeout event. Handles the spikes movement.
func _on_timer_timeout() -> void:
	if current_state == SpikeState.DOWN:
		animationPlayer.play("active")
		current_state = SpikeState.UP
	else:
		animationPlayer.play("idle")
		current_state = SpikeState.DOWN
	timer.start()


## Callback function for the body entered event. Inflicts damage on entities that collide with the spike when it is in the UP state.
func _on_body_entered(body) -> void:
	if body is Entity && current_state == SpikeState.UP:
		body.take_damage(SPIKE_DAMAGE, global_position)
