[GO BACK TO START](https://github.com/USEkipa/gra-logiczna/blob/main/docs/index.md)
# PlayerHUD

**Extends**: `Control`

## Table of contents

### Variables

|Name|Type|Default|
|:-|:-|:-|
|[player](#player)|`Player`|-|

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[set_player](#set_player)|`Player`|-|

## Variables

### player

```gdscript
var player: Player
```

Reference to the player object

|Name|Type|Default|
|:-|:-|:-|
|`player`|`Player`|-|

## Functions

### set_player

```gdscript
func set_player(_player: Player) -> void
```

Set the player for the HUD. Parameter _player: The player object.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`_player`|`Player`|-|

### update_ui

```gdscript
func update_ui() -> void
```

Update the HUD elements.

### _update_bullet_texture

```gdscript
func _update_bullet_texture() -> void
```

Update the bullet textures in the HUD based on the player's bullet count.


