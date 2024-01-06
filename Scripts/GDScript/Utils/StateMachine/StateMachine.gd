### ----------------------------------------------------
### Class used as a template object for all state machines:
### - Create state machine object with classes that manage coresponding states
### ----------------------------------------------------

extends RefCounted
class_name StateMachine

const ERROR = "ERROR_DEFAULT"

var verbose := false

## Describes currently set state of the state machine
var CurrentState: StateMachineState

## Shortcut to default state
var DefaultState: StateMachineState

## StateName [state Reference, ...]
var StateTable: Array[StateMachineState] = []


func _init(verbosity: bool = false) -> void:
	verbose = verbosity


## Adds state to StateTable and inits it
func add_state(state: StateMachineState) -> void:
	state.StateMaster = self
	if verbose:
		Logger.log_info(["Added new state: ", state.get_name()])
	StateTable.append(state)


## Sets a given state as current
func set_state(state: StateMachineState) -> bool:
	if not StateTable.has(state):
		Logger.log_error(["state not in Statetable, add it first with add_state(), ", state])
		return false
	if verbose:
		Logger.log_info(["Set new state: ", state])
	CurrentState = state
	CurrentState._state_set()
	return true


## Adds default state for state machine (easy access to default state)
func add_default_state(state: StateMachineState) -> bool:
	if not StateTable.has(state):
		Logger.log_error(["state not in Statetable, add it first with add_state(), ", state])
		return false
	if verbose:
		Logger.log_info(["Set default state: ", state])
	DefaultState = state
	return true


## Sets DefaultState as CurrentState
func set_default_state() -> bool:
	if DefaultState == null:
		Logger.log_error(["Failed to set default state (null)"])
		return false
	set_state(DefaultState)
	return true


## Wrapper to call update_delta of current state
func update_state_delta(delta: float) -> void:
	CurrentState.update_delta(delta)


## Wrapper to call update_input of current state
func update_state_input(event: InputEvent) -> void:
	CurrentState.update_input(event)


## Calls function of a given state and return the result, meant to be used for signals redirection
func redirect_signal(state: StateMachineState, functionName: StringName, argArr: Array) -> Variant:
	if not StateTable.has(state):
		Logger.log_error(["state not in StateTable, add it first with add_state(), ", state])
		return ERROR
	if not state == CurrentState:
		Logger.log_error(
			[
				"Sent signal to a state that is not currently set but exists in StateTable, ",
				state,
				" ",
				functionName
			]
		)
		return ERROR
	if not CurrentState.has_method(functionName):
		Logger.log_error(["state is missing function ", state, " ", functionName])
		return ERROR
	return Callable(state, functionName).callv(argArr)


## Calls function of a given state regardless if its a current state
func force_call(state: StateMachineState, functionName: StringName, argArr: Array) -> Variant:
	if not StateTable.has(state):
		Logger.log_error(["state not in StateTable, add it first with add_state(), ", state])
		return ERROR
	if not state.has_method(functionName):
		Logger.log_error(["state is missing function ", state, " ", functionName])
		return ERROR
	return Callable(state, functionName).callv(argArr)
