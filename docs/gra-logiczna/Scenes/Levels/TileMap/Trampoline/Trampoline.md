# Trampoline

**Extends**: `Area2D`

## Table of contents

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[_on_body_entered](#_on_body_entered)|`Node2D`|-|
|[characterBody2D_accelerate_up](#characterbody2d_accelerate_up)|`CharacterBody2D`|-|
|[rigidBody2D_accelerate_up](#rigidbody2d_accelerate_up)|`RigidBody2D`|-|

## Functions

### _on_body_entered

```gdscript
func _on_body_entered(body: Node2D) -> void
```

Callback function triggered when a body enters the area.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`body`|`Node2D`|-|

### characterBody2D_accelerate_up

```gdscript
func characterBody2D_accelerate_up(body: CharacterBody2D)
```

Accelerates the provided CharacterBody2D upward and plays the "active" animation.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`body`|`CharacterBody2D`|-|

### rigidBody2D_accelerate_up

```gdscript
func rigidBody2D_accelerate_up(body: RigidBody2D)
```

Accelerates the provided RigidBody2D downward and plays the "active" animation.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`body`|`RigidBody2D`|-|


