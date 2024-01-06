# StateMachine

**Extends**: `RefCounted`

## Table of contents

### Variables

|Name|Type|Default|
|:-|:-|:-|
|[CurrentState](#currentstate)|`StateMachineState`|-|
|[DefaultState](#defaultstate)|`StateMachineState`|-|
|[StateTable](#statetable)|`Array[StateMachineState]`|`[]`|

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[add_state](#add_state)|`StateMachineState`|-|
|[set_state](#set_state)|`StateMachineState`|-|
|[add_default_state](#add_default_state)|`StateMachineState`|-|
|[update_state_delta](#update_state_delta)|`float`|-|
|[update_state_input](#update_state_input)|`InputEvent`|-|
|[redirect_signal](#redirect_signal)|`StateMachineState`|-|
|[force_call](#force_call)|`StateMachineState`|-|

## Variables

### CurrentState

```gdscript
var CurrentState: StateMachineState
```

Describes currently set state of the state machine

|Name|Type|Default|
|:-|:-|:-|
|`CurrentState`|`StateMachineState`|-|

### DefaultState

```gdscript
var DefaultState: StateMachineState
```

Shortcut to default state

|Name|Type|Default|
|:-|:-|:-|
|`DefaultState`|`StateMachineState`|-|

### StateTable

```gdscript
var StateTable: Array[StateMachineState] = []
```

StateName [state Reference, ...]

|Name|Type|Default|
|:-|:-|:-|
|`StateTable`|`Array[StateMachineState]`|`[]`|

## Functions

### add_state

```gdscript
func add_state(state: StateMachineState) -> void
```

Adds state to StateTable and inits it

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`state`|`StateMachineState`|-|

### set_state

```gdscript
func set_state(state: StateMachineState) -> bool
```

Sets a given state as current

**Returns**: `bool`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`state`|`StateMachineState`|-|

### add_default_state

```gdscript
func add_default_state(state: StateMachineState) -> bool
```

Adds default state for state machine (easy access to default state)

**Returns**: `bool`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`state`|`StateMachineState`|-|

### set_default_state

```gdscript
func set_default_state() -> bool
```

Sets DefaultState as CurrentState

**Returns**: `bool`

### update_state_delta

```gdscript
func update_state_delta(delta: float) -> void
```

Wrapper to call update_delta of current state

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`delta`|`float`|-|

### update_state_input

```gdscript
func update_state_input(event: InputEvent) -> void
```

Wrapper to call update_input of current state

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`event`|`InputEvent`|-|

### redirect_signal

```gdscript
func redirect_signal(state: StateMachineState, functionName: StringName, argArr: Array) -> Variant
```

Calls function of a given state and return the result, meant to be used for signals redirection

**Returns**: `Variant`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`state`|`StateMachineState`|-|
|`functionName`|`StringName`|-|
|`argArr`|`Array`|-|

### force_call

```gdscript
func force_call(state: StateMachineState, functionName: StringName, argArr: Array) -> Variant
```

Calls function of a given state regardless if its a current state

**Returns**: `Variant`

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`state`|`StateMachineState`|-|
|`functionName`|`StringName`|-|
|`argArr`|`Array`|-|


