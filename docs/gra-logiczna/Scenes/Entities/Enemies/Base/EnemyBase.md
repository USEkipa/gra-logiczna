# EnemyBase

**Extends**: `Entity`

## Table of contents

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[force_animation](#force_animation)|`String`|-|

## Functions

### try_fetch_level_enviroment

```gdscript
func try_fetch_level_enviroment() -> void
```

Initialization of the enemy, fetches world info

### force_animation

```gdscript
func force_animation(animationName: String, timeMs: int) -> void
```

Forces animation to play for a given duration of time

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`animationName`|`String`|-|
|`timeMs`|`int`|-|

### _die

```gdscript
func _die() -> void
```

Removes enemy and plays death animation


