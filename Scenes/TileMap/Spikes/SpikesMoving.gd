extends Area2D

var animation_player: AnimationPlayer
var timer: Timer

enum SpikeState { UP, DOWN }

var current_state: SpikeState = SpikeState.DOWN

func _ready():
	animation_player = $AnimationPlayer
	$Timer.start()
	
	animation_player.play("idle")

func _on_timer_timeout():
	if current_state == SpikeState.DOWN:
		# If spikes are down, raise them
		animation_player.play("active")
		current_state = SpikeState.UP
		checkForPlayerCollision()
	else:
		# If spikes are up, lower them
		animation_player.play("idle")
		current_state = SpikeState.DOWN
	$Timer.start()

func checkForPlayerCollision():
	# Check for collisions with the Player object
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is Player:
			body.take_damage(10, global_position)

func _on_body_entered(body):
	if body is Player && current_state == SpikeState.UP:
		body.take_damage(10, global_position)
