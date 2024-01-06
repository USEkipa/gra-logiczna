[GO BACK TO START](https://github.com/USEkipa/gra-logiczna/blob/main/docs/index.md)
# MovingPlatform

**Extends**: `Node2D`

## Table of contents

### Variables

|Name|Type|Default|
|:-|:-|:-|
|[startingPositon](#startingpositon)|`Vector2`|-|
|[endingPositon](#endingpositon)|`Vector2`|-|

### Functions

|Name|Type|Default|
|:-|:-|:-|

## Variables

### startingPositon

```gdscript
var startingPositon: Vector2
```

A Vector2 representing the starting position of the platform.

|Name|Type|Default|
|:-|:-|:-|
|`startingPositon`|`Vector2`|-|

### endingPositon

```gdscript
var endingPositon: Vector2
```

A Vector2 representing the ending position of the platform.

|Name|Type|Default|
|:-|:-|:-|
|`endingPositon`|`Vector2`|-|

## Functions

### _ready

```gdscript
func _ready() -> void
```

Called when the scene is ready. Initializes the starting and ending positions and starts the tweening animation.

### start_tween

```gdscript
func start_tween() -> void
```

Configures and starts the tweening animation for the platform's movement.

### _exit_tree

```gdscript
func _exit_tree() -> void
```

Called when the node is about to be removed from the scene tree. Kills the tween to clean up resources.


