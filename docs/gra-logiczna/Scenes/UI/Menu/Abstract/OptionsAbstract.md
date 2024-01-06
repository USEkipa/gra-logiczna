[GO BACK TO START](https://github.com/USEkipa/gra-logiczna/blob/main/docs/index.md)
# Options

**Extends**: `Control`

## Table of contents

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[_on_volume_slider_value_changed](#_on_volume_slider_value_changed)|`float`|-|

## Functions

### _ready

```gdscript
func _ready() -> void
```

Function sets up buttons and sliders when menu is ready

### _on_toggle_full_screen_pressed

```gdscript
func _on_toggle_full_screen_pressed() -> void
```

Function run when `toggleFullScreen` button is pressed

 Function will play `BUTTON_CLICK` sound and if button is checked then the game will be displayed in fullscreen mode, otherwise it will revert back to the windowed mode.

### _on_toggle_music_pressed

```gdscript
func _on_toggle_music_pressed() -> void
```

Function run when `toggleMusic` button is pressed

 Function will play `BUTTON_CLICK` sound and if button is checked then the game's music will be muted, otherwise the game's music volume will be reverted back to its previous state.

### _on_volume_slider_value_changed

```gdscript
func _on_volume_slider_value_changed(value: float) -> void
```

Function run when `volumeSlider's` value is changed

 Function will play `BUTTON_CLICK` sound and based on the slider's current value the game's volume will be changed.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`value`|`float`|-|

### _on_volume_up_btn_pressed

```gdscript
func _on_volume_up_btn_pressed() -> void
```

Function run when `volumeUp` button is pressed

 Function will play `BUTTON_CLICK` sound and increase the game's volume by 1.

### _on_volume_down_btn_pressed

```gdscript
func _on_volume_down_btn_pressed() -> void
```

Function run when `volumeDown` button is pressed

 Function will play `BUTTON_CLICK` sound and decrease the game's volume by 1.


