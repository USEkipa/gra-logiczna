[GO BACK TO START](https://github.com/USEkipa/gra-logiczna/blob/main/docs/index.md)
# Ammo

**Extends**: `MarginContainer`

## Table of contents

### Variables

|Name|Type|Default|
|:-|:-|:-|
|[bulletCount](#bulletcount)|`int`|`0`|

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[_input](#_input)|`InputEvent`|-|

## Variables

### bulletCount

```gdscript
var bulletCount: int = 0
```

Current count of bullets

|Name|Type|Default|
|:-|:-|:-|
|`bulletCount`|`int`|`0`|

## Functions

### add_bullet

```gdscript
func add_bullet() -> bool
```

Add a bullet to the HUD. Returns: True if the bullet was added successfully, false otherwise.

**Returns**: `bool`

### remove_bullet

```gdscript
func remove_bullet() -> bool
```

Remove a bullet from the HUD. Returns: True if the bullet was removed successfully, false otherwise.

**Returns**: `bool`

### _update_bullet_texture

```gdscript
func _update_bullet_texture()
```

Update the bullet textures in the HUD based on the bullet count.

### _input

```gdscript
func _input(_event: InputEvent) -> void
```

Handle input events for debugging. Parameter _event: The input event.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`_event`|`InputEvent`|-|


