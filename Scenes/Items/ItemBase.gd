extends Sprite2D

class_name ItemBase

@export var item_name: String = "none"
@export var item_value: int = 0

@onready var moveTween: Tween

var startPosition: Vector2
var moveTo := Vector2(0, -2)


func start_tween() -> void:
	startPosition = global_position
	moveTo = startPosition + moveTo
	moveTween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	moveTween.set_loops().set_parallel(false)
	moveTween.tween_property(self, "position", moveTo, 1)
	moveTween.tween_property(self, "position", startPosition, 1)


func _exit_tree() -> void:
	moveTween.kill()
