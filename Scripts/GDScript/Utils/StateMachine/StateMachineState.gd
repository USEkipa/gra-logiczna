### ----------------------------------------------------
### Template state, every state in inherited Statemachine should have these Functions
### ----------------------------------------------------

extends RefCounted
class_name StateMachineState

# Parent state machine, reference used for switching states inside of a given state
var StateMaster

var name: String


# Automatically assigns Variables in State to Variables in parent (by reference)
func _init() -> void:
	name = get_script().get_path().get_file().get_basename()


# Called whenever a state is set as current by StateMachine
func _state_set() -> void:
	pass


# Set of instructions executed at the end of state, can be overwritten
func end_state() -> void:
	StateMaster.set_default_state()


# Returns name of a state
func get_name() -> String:
	return name


# For physics process
func update_delta(_delta: float) -> void:
	Logger.log_error(["Function should be overridden"])


# For input event
func update_input(_event: InputEvent) -> void:
	Logger.log_error(["Function should be overridden"])


func _to_string() -> String:
	return get_name()
