[GO BACK TO START](https://github.com/USEkipa/gra-logiczna/blob/main/docs/index.md)
# PlayerBullet

**Extends**: `Area2D`

## Table of contents

### Variables

|Name|Type|Default|
|:-|:-|:-|
|[damage](#damage)|`int`|`20`|
|[direction](#direction)|`Vector2`|`Vector2.LEFT`|

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[_process](#_process)|`-`|-|
|[_on_body_entered](#_on_body_entered)|`Node2D`|-|

## Variables

### damage

```gdscript
var damage: int = 20
```

Damage inflicted by the player bullet.

|Name|Type|Default|
|:-|:-|:-|
|`damage`|`int`|`20`|

### direction

```gdscript
var direction: Vector2 = Vector2.LEFT
```

Direction of the player bullet.

|Name|Type|Default|
|:-|:-|:-|
|`direction`|`Vector2`|`Vector2.LEFT`|

## Functions

### _ready

```gdscript
func _ready() -> void
```

Called when the node is added to the scene.

### _process

```gdscript
func _process(delta) -> void
```

Called every frame. Parameter delta: The time elapsed since the last frame.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`delta`|-|-|

### _on_bullet_life_duration_timeout

```gdscript
func _on_bullet_life_duration_timeout() -> void
```

Called when the BulletLifeDuration timer times out.

### _on_body_entered

```gdscript
func _on_body_entered(body: Node2D) -> void
```

Called when a body enters the area. Parameter body: The entered body.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`body`|`Node2D`|-|


