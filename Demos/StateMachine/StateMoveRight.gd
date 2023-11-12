extends StateMachineState

class_name StateMoveRight

var elementToMove: Control


func _state_set() -> void:
	print("state move right set")


func update_delta(_delta: float) -> void:
	if elementToMove.position.x < 200:
		elementToMove.position.x += 1
