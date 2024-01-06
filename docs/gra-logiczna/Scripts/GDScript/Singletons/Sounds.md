# Sounds

**Singleton**

**Extends**: `Node`

## Table of contents

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[play_sound](#play_sound)|`-`|-|
|[play_loop_sound](#play_loop_sound)|`-`|-|
|[change_volume](#change_volume)|`-`|`Globals.options.volume`|

## Functions

### _ready

```gdscript
func _ready()
```

Called when the node is added to the scene.

### play_sound

```gdscript
func play_sound(soundtype, volume_percent = Globals.options.volume)
```

Play a non-looping sound. Parameter soundtype: The type of sound to play. Parameter volume_percent: Optional. The volume level as a percentage (default is Globals.options.volume).

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`soundtype`|-|-|
|`volume_percent `|-|`Globals.options.volume`|

### play_loop_sound

```gdscript
func play_loop_sound(soundtype, volume_percent = Globals.options.volume)
```

Play a looping sound. Parameter soundtype: The type of sound to play. Parameter volume_percent: Optional. The volume level as a percentage (default is Globals.options.volume).

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`soundtype`|-|-|
|`volume_percent `|-|`Globals.options.volume`|

### stop_loop_sound

```gdscript
func stop_loop_sound()
```

Stop the currently looping sound.

### change_volume

```gdscript
func change_volume(volume_percent = Globals.options.volume)
```

Change the volume of the looping sound. Parameter volume_percent: Optional. The volume level as a percentage (default is Globals.options.volume).

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`volume_percent `|-|`Globals.options.volume`|


