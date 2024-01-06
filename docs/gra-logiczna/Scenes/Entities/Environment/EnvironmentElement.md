[GO BACK TO START](https://github.com/USEkipa/gra-logiczna/blob/main/docs/index.md)
# EnviromentEntity

**Extends**: `RigidBody2D`

## Table of contents

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[_physics_process](#_physics_process)|`float`|-|
|[process_idle_chipped_state](#process_idle_chipped_state)|`float`|-|
|[change_state](#change_state)|`int`|-|
|[take_damage](#take_damage)|`int`|-|

## Functions

### _ready

```gdscript
func _ready() -> void
```

Function changes the current state of a movable object on `idle` when ready

### _physics_process

```gdscript
func _physics_process(delta: float) -> void
```

Function responsible for running different logic based on object's state.

 Params:

 `delta`: `float`		delta time since previous frame

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`delta`|`float`|-|

### process_destroyed_state

```gdscript
func process_destroyed_state() -> void
```

Function containing logic for destroing the object.

 Function stops the angular movement of the object and awaits the end of `destroyed` animation

### process_idle_chipped_state

```gdscript
func process_idle_chipped_state(delta: float) -> void
```

Function containing logic for `idle` and `chipped` states.

 Function calculates an object's linear velocity on set time intervals used to calculate damage dealt to entities.

 Params:

 `delta`: `float`		delta time since previous frame

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`delta`|`float`|-|

### change_state

```gdscript
func change_state(newState: int) -> void
```

Function responsible for changing the object's state

 Based on the argument the state is changed accordingly, and specific to the state animation is played.

 Params:

 `newState`: `int`		enum value of the state to change to

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`newState`|`int`|-|

### get_object_speed

```gdscript
func get_object_speed() -> float
```

Function calculating the linear speed of the object

 The speed is calculated using pitagorean formula.

 Return:

 `result`: `float`		the linear speed of the object

**Returns**: `float`

### take_damage

```gdscript
func take_damage(damage: int, _attackSourcePosition: Vector2) -> void
```

Function responsible for damaging the the object

 Function first checks if the object is in `destroyed` state, and if so it doesn't proceed with its logic. Otherwise the damge value is subtracted from the current health and if said health reaches half of max health the state is changed to chipped. When health reaches 0 the state is changed to `destroyed`.

 Params:

 `damage`: `int`							value that is going to be subtracted from current health

 `_attackSourcePosition`: `Vector2`		vector value of the damage source position

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`damage`|`int`|-|
|`_attackSourcePosition`|`Vector2`|-|


