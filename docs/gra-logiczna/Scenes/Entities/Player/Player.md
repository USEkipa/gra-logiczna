[GO BACK TO START](https://github.com/USEkipa/gra-logiczna/blob/main/docs/index.md)
# Player

**Extends**: `Entity`

## Table of contents

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[add_bullets](#add_bullets)|`int`|-|
|[add_score](#add_score)|`int`|-|
|[take_damage](#take_damage)|`int`|-|
|[health_picked_up](#health_picked_up)|`int`|-|
|[add_interaction](#add_interaction)|`UpgradeItemBase`|-|
|[erase_interaction](#erase_interaction)|`UpgradeItemBase`|-|
|[change_bulletTimer_speed](#change_bullettimer_speed)|`float`|-|
|[_physics_process](#_physics_process)|`float`|-|
|[_input](#_input)|`InputEvent`|-|

## Functions

### _ready

```gdscript
func _ready() -> void
```

Called when the scene is ready. Initializes various components and sets up the players initial state.

### add_bullets

```gdscript
func add_bullets(amount: int) -> void
```

Increases the players bullet count by the specified amount.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`amount`|`int`|-|

### add_score

```gdscript
func add_score(amount: int) -> void
```

Increases the players score by the specified amount.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`amount`|`int`|-|

### take_damage

```gdscript
func take_damage(amount: int, objectPosition: Vector2) -> void
```

Handles the player taking damage, applying effects and updating the HUD.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`amount`|`int`|-|
|`objectPosition`|`Vector2`|-|

### health_picked_up

```gdscript
func health_picked_up(count: int) -> void
```

Handles the player picking up health, updating the HUD.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`count`|`int`|-|

### _on_bullet_timer_timeout

```gdscript
func _on_bullet_timer_timeout() -> void
```

Callback function when the bulletTimer expires, allowing the player to shoot again.

### get_random_marker

```gdscript
func get_random_marker() -> Marker2D
```

Returns a random Marker2D from the BulletStartPositions node.

**Returns**: `Marker2D`

### _on_animations_animation_finished

```gdscript
func _on_animations_animation_finished() -> void
```

Callback function when an animation finishes, handling player state changes and effects.

### update_pickUpLabel_visibility

```gdscript
func update_pickUpLabel_visibility() -> void
```

Updates the visibility of the interaction prompt label based on available interactions.

### add_interaction

```gdscript
func add_interaction(interaction: UpgradeItemBase) -> void
```

Adds an interaction to the list and updates the visibility of the interaction prompt label.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`interaction`|`UpgradeItemBase`|-|

### erase_interaction

```gdscript
func erase_interaction(interaction: UpgradeItemBase) -> void
```

Removes an interaction from the list and updates the visibility of the interaction prompt label.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`interaction`|`UpgradeItemBase`|-|

### execute_interaction

```gdscript
func execute_interaction() -> void
```

Executes the current interaction, if available.

### change_bulletTimer_speed

```gdscript
func change_bulletTimer_speed(count: float) -> void
```

Changes the bullet timer speed based on the provided count.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`count`|`float`|-|

### _physics_process

```gdscript
func _physics_process(delta: float) -> void
```

Handles physics-related updates, including state machine updates and interaction execution.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`delta`|`float`|-|

### _input

```gdscript
func _input(event: InputEvent) -> void
```

Handles input events, updating the state machine based on user input.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`event`|`InputEvent`|-|


