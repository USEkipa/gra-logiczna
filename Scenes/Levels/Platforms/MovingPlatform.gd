extends Node2D

@export var duration := 5.0
@onready var platform: AnimatableBody2D = $Platform
@onready var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
@onready var targetMarker: Marker2D = $EndingPosition

var startingPositon: Vector2
var endingPositon: Vector2


func _ready() -> void:
	startingPositon = global_position
	endingPositon = targetMarker.global_position
	start_tween()


func start_tween() -> void:
	tween.set_loops().set_parallel(false)
	tween.tween_property(platform, "global_position", endingPositon, duration / 2)
	tween.tween_property(platform, "global_position", startingPositon, duration / 2)


func _exit_tree() -> void:
	tween.kill()
