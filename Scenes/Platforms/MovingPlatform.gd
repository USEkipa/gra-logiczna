extends Node2D

@export var targetPosition : Vector2 = Vector2(0, 0)
@export var duration := 5.0

@onready var platform : AnimatableBody2D = $Platform

var startPosition : Vector2  # Variable to store the starting position
@onready var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
# Called when the node enters the scene tree for the first time.
func _ready():
	start_tween()

func start_tween():
	tween.set_loops().set_parallel(false)
	tween.tween_property(platform, "position", targetPosition, duration / 2)
	tween.tween_property(platform, "position", Vector2.ZERO, duration / 2)

func _exit_tree():
	tween.kill()
