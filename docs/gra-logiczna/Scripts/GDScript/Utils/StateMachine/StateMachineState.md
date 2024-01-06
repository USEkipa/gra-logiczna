# StateMachineState

**Extends**: `RefCounted`

## Table of contents

### Variables

|Name|Type|Default|
|:-|:-|:-|
|[StateMaster](#statemaster)|`StateMachine`|-|

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[update_delta](#update_delta)|`float`|-|
|[update_input](#update_input)|`InputEvent`|-|

## Variables

### StateMaster

```gdscript
var StateMaster: StateMachine
```

Parent state machine, reference used for switching states inside of a given state

|Name|Type|Default|
|:-|:-|:-|
|`StateMaster`|`StateMachine`|-|

## Functions

### _state_set

```gdscript
func _state_set() -> void
```

Called whenever a state is set as current by StateMachine

### end_state

```gdscript
func end_state() -> void
```

Set of instructions executed at the end of state, can be overwritten

### get_name

```gdscript
func get_name() -> String
```

Returns name of a state

**Returns**: `String`

### update_delta

```gdscript
func update_delta(_delta: float) -> void
```

For physics process

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`_delta`|`float`|-|

### update_input

```gdscript
func update_input(_event: InputEvent) -> void
```

For input event

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`_event`|`InputEvent`|-|


