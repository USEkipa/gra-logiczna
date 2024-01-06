# PlayerEnviroment

**Extends**: `Node2D`

## Table of contents

### Constants

|Name|Type|Default|
|:-|:-|:-|
|[BULLET_SCENE](#bullet_scene)|`-`|`preload(`|

### Variables

|Name|Type|Default|
|:-|:-|:-|
|[projectiles](#projectiles)|`Node2D`|`null`|

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[bullet_shot](#bullet_shot)|`Vector2`|-|

## Constants

### BULLET_SCENE

```gdscript
const BULLET_SCENE: PackedScene = preload(
```

A constant PackedScene representing the PlayerBullet scene, preloaded for efficient instantiation.

|Name|Type|Default|
|:-|:-|:-|
|`BULLET_SCENE`|-|`preload(`|

## Variables

### projectiles

```gdscript
var projectiles: Node2D = null
```

A Node2D used to group and manage player bullets.

|Name|Type|Default|
|:-|:-|:-|
|`projectiles`|`Node2D`|`null`|

## Functions

### _ready

```gdscript
func _ready() -> void
```

Called when the scene is ready. Initializes the projectiles node and connects the "bullet_shot" signal from the player.

### bullet_shot

```gdscript
func bullet_shot(pos: Vector2, direction: Vector2) -> void
```

Handles the event when the player shoots a bullet.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`pos`|`Vector2`|-|
|`direction`|`Vector2`|-|


