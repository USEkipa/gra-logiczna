extends StateMachineState

class_name StateMoveLeft

var elementToMove: Control


func _state_set() -> void:
	print("state move left set")


func update_delta(_delta: float) -> void:
	if elementToMove.position.x > 0:
		elementToMove.position.x -= 1
