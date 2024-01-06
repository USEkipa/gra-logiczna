extends Node2D

## The duration (in seconds) for the platform movement tween.
@export var duration := 5.0
## An AnimatableBody2D representing the moving platform.
@onready var platform: AnimatableBody2D = $Platform
## A Tween object for handling animation and tweening.
@onready var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
## A Marker2D representing the target position for the platform.
@onready var targetMarker: Marker2D = $EndingPosition
## A Vector2 representing the starting position of the platform.
var startingPositon: Vector2
## A Vector2 representing the ending position of the platform.
var endingPositon: Vector2


## Called when the scene is ready. Initializes the starting and ending positions and starts the tweening animation.
func _ready() -> void:
	startingPositon = global_position
	endingPositon = targetMarker.global_position
	start_tween()


## Configures and starts the tweening animation for the platform's movement.
func start_tween() -> void:
	tween.set_loops().set_parallel(false)
	tween.tween_property(platform, "global_position", endingPositon, duration / 2)
	tween.tween_property(platform, "global_position", startingPositon, duration / 2)


## Called when the node is about to be removed from the scene tree. Kills the tween to clean up resources.
func _exit_tree() -> void:
	tween.kill()
