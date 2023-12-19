extends Area2D

const SPIKE_DAMAGE = 100

### Variables:
- **animationPlayer**: An onready variable referencing the AnimationPlayer node responsible for managing animations.
- **timer**: An onready variable referencing the Timer node used to control spike movements.
- **current_state**: Represents the current state of the spike (either UP or DOWN).

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer

enum SpikeState { UP, DOWN }

var current_state: SpikeState = SpikeState.DOWN

### Function: `_ready()`
- **Description**: Called when the scene is ready. Initializes the timer and plays the idle animation.
- **Actions**:
  - Starts the timer.
  - Plays the "idle" animation.
func _ready() -> void:
	timer.start()
	animationPlayer.play("idle")

### Function: `_on_timer_timeout()`
- **Description**: Callback function for the timer timeout event. Handles the spikes movement.
- **Actions**:
  - If the spike is DOWN, plays the "active" animation and sets the state to UP.
  - If the spike is UP, plays the "idle" animation and sets the state to DOWN.
  - Restarts the timer.
func _on_timer_timeout() -> void:
	if current_state == SpikeState.DOWN:
		animationPlayer.play("active")
		current_state = SpikeState.UP
	else:
		animationPlayer.play("idle")
		current_state = SpikeState.DOWN
	timer.start()

### Function: `_on_body_entered(body)`
- **Description**: Callback function for the body entered event. Inflicts damage on entities that collide with the spike when it is in the UP state.
- **Parameters**:
  - `body`: The body that entered the spikes area.
- **Actions**:
  - Checks if the colliding body is an Entity and if the spike is in the UP state.
  - Calls the `take_damage` function on the colliding body with the specified damage and global position.
func _on_body_entered(body) -> void:
	if body is Entity && current_state == SpikeState.UP:
		body.take_damage(SPIKE_DAMAGE, global_position)
