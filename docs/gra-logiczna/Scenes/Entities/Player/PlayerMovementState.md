# PlayerMovementState

**Extends**: `StateMachineState`

## Table of contents

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[set_player](#set_player)|`Player`|-|
|[change_components_direction](#change_components_direction)|`-`|-|
|[runManager](#runmanager)|`Vector2`|-|
|[update_input](#update_input)|`InputEvent`|-|
|[update_delta](#update_delta)|`float`|-|

## Functions

### set_player

```gdscript
func set_player(_player: Player) -> void
```

Function used on initial configuration of the player's movement state

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`_player`|`Player`|-|

### change_components_direction

```gdscript
func change_components_direction(direction) -> void
```

Function changes player's components direction

 Based on the player's movement direction the components such as animations, gpu particles, and bullet starting positions are flipped.

 Params:

 `direction`: `Vector2`		player's movement direction

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`direction`|-|-|

### get_direction

```gdscript
func get_direction() -> Vector2
```

Function changes gets the player's movement direction

 Based on input key, the direction can be changed to `left`, `right` or `zero` when none of the directional keys are pressed.

 Return:

 `direction`: `Vector2`		player's movement direction

**Returns**: `Vector2`

### jumpManager

```gdscript
func jumpManager() -> void
```

Function responsible for managing jumping

 If jump key is pressed and the player has at least one jump avaible then function will play `jump` animation and set a new y velocity. Otherwise if player is not on the floor then the function will play `fall` animation.

### runManager

```gdscript
func runManager(direction: Vector2) -> void
```

Function responsible for managing running

 Function will check the movement direction of the player and if it is `zero`, then the `idle` animation is going to be played, otherwise the `run` animation is going to be played.

 Params:

 `direction`: `Vector2`		player's movement direction

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`direction`|`Vector2`|-|

### shootingManager

```gdscript
func shootingManager() -> void
```

Function responsible for managing shooting

 If shoot button is pressed and the player is able to shoot then function will start emitting particles and will also emit a signal for rednering a bullet.

### meleeAttackManager

```gdscript
func meleeAttackManager() -> void
```

Function responsible for managing melee attack

 If attack button is pressed and the player is able to attack then function will playe `ATTACK` sound and start a countdown for the next attack.

### reset_jumps

```gdscript
func reset_jumps() -> void
```

Function responsible for resetting avaible jumps

 If player is on the floor and at least one jump has been used, then the function will reset avaible jumps back to it's maximum value.

### update_input

```gdscript
func update_input(event: InputEvent) -> void
```

Function responsible for letting player go down from the platforms

 Params:

 `event`: `InputEvent`		key pressed

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`event`|`InputEvent`|-|

### update_delta

```gdscript
func update_delta(_delta: float) -> void
```

Function responsible for putting together all of the movement functionality

 Function puts together all of the movement functionality and also adds a stagger time when player is being hit.

 Params:

 `_delta`: `float`		delta time since previous frame

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`_delta`|`float`|-|


