extends Node2D

## Variables:
- **duration**: The duration (in seconds) for the platform movement tween.
- **platform**: An AnimatableBody2D representing the moving platform.
- **tween**: A Tween object for handling animation and tweening.
- **targetMarker**: A Marker2D representing the target position for the platform.
- **startingPositon**: A Vector2 representing the starting position of the platform.
- **endingPositon**: A Vector2 representing the ending position of the platform.
@export var duration := 5.0
@onready var platform: AnimatableBody2D = $Platform
@onready var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
@onready var targetMarker: Marker2D = $EndingPosition
var startingPositon: Vector2
var endingPositon: Vector2

## Function: `_ready()`
- **Description**: Called when the scene is ready. Initializes the starting and ending positions and starts the tweening animation.
- **Actions**:
  - Sets the starting and ending positions.
  - Calls the `start_tween()` function.
func _ready() -> void:
	startingPositon = global_position
	endingPositon = targetMarker.global_position
	start_tween()

## Function: `start_tween()`
- **Description**: Configures and starts the tweening animation for the platform's movement.
- **Actions**:
  - Configures the tween to have no loops and run sequentially.
  - Sets up two tweening properties for the platform's global position: one from starting to ending, and another from ending back to starting.
  - Starts the tween with a duration divided by 2 for each segment.
func start_tween() -> void:
	tween.set_loops().set_parallel(false)
	tween.tween_property(platform, "global_position", endingPositon, duration / 2)
	tween.tween_property(platform, "global_position", startingPositon, duration / 2)

## Function: `_exit_tree()`
- **Description**: Called when the node is about to be removed from the scene tree. Kills the tween to clean up resources.
- **Actions**:
  - Calls the `kill()` method on the tween object to stop and clean up the tween.
func _exit_tree() -> void:
	tween.kill()
