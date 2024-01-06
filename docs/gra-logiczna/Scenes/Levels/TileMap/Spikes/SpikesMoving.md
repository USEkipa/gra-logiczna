# SpikesMoving

**Extends**: `Area2D`

## Table of contents

### Variables

|Name|Type|Default|
|:-|:-|:-|
|[current_state](#current_state)|`SpikeState`|`SpikeState.DOWN`|

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[_on_body_entered](#_on_body_entered)|`-`|-|

## Variables

### current_state

```gdscript
var current_state: SpikeState = SpikeState.DOWN
```

Represents the current state of the spike (either UP or DOWN).

|Name|Type|Default|
|:-|:-|:-|
|`current_state`|`SpikeState`|`SpikeState.DOWN`|

## Functions

### _ready

```gdscript
func _ready() -> void
```

Called when the scene is ready. Initializes the timer and plays the idle animation.

### _on_timer_timeout

```gdscript
func _on_timer_timeout() -> void
```

Callback function for the timer timeout event. Handles the spikes movement.

### _on_body_entered

```gdscript
func _on_body_entered(body) -> void
```

Callback function for the body entered event. Inflicts damage on entities that collide with the spike when it is in the UP state.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`body`|-|-|


