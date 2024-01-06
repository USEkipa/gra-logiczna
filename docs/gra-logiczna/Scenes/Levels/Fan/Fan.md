[GO BACK TO START](https://github.com/USEkipa/gra-logiczna/blob/main/docs/index.md)
# Fan

**Extends**: `Node2D`

## Table of contents

### Signals

|Name|Type|Default|
|:-|:-|:-|

### Constants

|Name|Type|Default|
|:-|:-|:-|
|[MAX_WIND_SPEED](#max_wind_speed)|`int`|`100`|

### Variables

|Name|Type|Default|
|:-|:-|:-|
|[baseWindStrenght](#basewindstrenght)|`int`|`Globals.World.GRAVITY`|
|[animation_player](#animation_player)|`AnimationPlayer`|-|
|[characterBodiesInFanArea](#characterbodiesinfanarea)|`Array[CharacterBody2D]`|`[]`|
|[rigidBodiesInFanArea](#rigidbodiesinfanarea)|`Array[RigidBody2D]`|`[]`|
|[direction](#direction)|`Vector2`|-|

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[_physics_process](#_physics_process)|`-`|-|
|[_on_wind_body_entered](#_on_wind_body_entered)|`-`|-|
|[_on_wind_body_exited](#_on_wind_body_exited)|`-`|-|

## Signals

### wind

```gdscript
signal wind
```

An emitted signal representing the wind event.

## Constants

### MAX_WIND_SPEED

```gdscript
const MAX_WIND_SPEED = 100
```

A constant representing the maximum wind speed, set to 100.

|Name|Type|Default|
|:-|:-|:-|
|`MAX_WIND_SPEED`|`int`|`100`|

## Variables

### baseWindStrenght

```gdscript
var baseWindStrenght: int = Globals.World.GRAVITY
```

An integer representing the base wind strength derived from the global gravity in the game.

|Name|Type|Default|
|:-|:-|:-|
|`baseWindStrenght`|`int`|`Globals.World.GRAVITY`|

### animation_player

```gdscript
var animation_player: AnimationPlayer
```

An AnimationPlayer node responsible for playing animations.

|Name|Type|Default|
|:-|:-|:-|
|`animation_player`|`AnimationPlayer`|-|

### characterBodiesInFanArea

```gdscript
var characterBodiesInFanArea: Array[CharacterBody2D] = []
```

An array storing CharacterBody2D objects within the wind fan area.

|Name|Type|Default|
|:-|:-|:-|
|`characterBodiesInFanArea`|`Array[CharacterBody2D]`|`[]`|

### rigidBodiesInFanArea

```gdscript
var rigidBodiesInFanArea: Array[RigidBody2D] = []
```

An array storing RigidBody2D objects within the wind fan area.

|Name|Type|Default|
|:-|:-|:-|
|`rigidBodiesInFanArea`|`Array[RigidBody2D]`|`[]`|

### direction

```gdscript
var direction: Vector2
```

A Vector2 representing the direction of the wind.

|Name|Type|Default|
|:-|:-|:-|
|`direction`|`Vector2`|-|

## Functions

### _ready

```gdscript
func _ready() -> void
```

Called when the scene is ready. Initializes the AnimationPlayer and calculates the direction of the wind.

### _physics_process

```gdscript
func _physics_process(_delta) -> void
```

Called every physics frame. Applies wind force to character bodies and rigid bodies within the fan area.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`_delta`|-|-|

### _on_wind_body_entered

```gdscript
func _on_wind_body_entered(body) -> void
```

Signal callback when a body enters the wind fan area.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`body`|-|-|

### _on_wind_body_exited

```gdscript
func _on_wind_body_exited(body) -> void
```

Signal callback when a body exits the wind fan area.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`body`|-|-|

### get_wind_strenght

```gdscript
func get_wind_strenght() -> int
```

Returns the current wind strength, combining the base wind strength and the exported wind strength.

**Returns**: `int`


