extends Node2D

var stateMachine := StateMachine.new(true)
var stateMoveRight := StateMoveRight.new()
var stateMoveLeft := StateMoveLeft.new()


func _ready() -> void:
	stateMachine.add_state(stateMoveRight)
	stateMachine.add_state(stateMoveLeft)

	stateMoveRight.elementToMove = get_node("Move")
	stateMoveLeft.elementToMove = get_node("Move")
	stateMachine.set_state(stateMoveRight)


func _physics_process(delta: float) -> void:
	stateMachine.update_state_delta(delta)


func _input(event: InputEvent) -> void:
	stateMachine.update_state_input(event)

	if event.is_action_pressed("left"):
		stateMachine.set_state(stateMoveLeft)
	if event.is_action_pressed("right"):
		stateMachine.set_state(stateMoveRight)
