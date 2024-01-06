# LevelBase

**Extends**: `Node2D`

## Table of contents

### Functions

|Name|Type|Default|
|:-|:-|:-|
|[_input](#_input)|`InputEvent`|-|

## Functions

### _ready

```gdscript
func _ready() -> void
```

Called when the scene is ready. Initializes various components, connects signals, and sets up the initial game state.

### _input

```gdscript
func _input(event: InputEvent) -> void
```

Handles input events, specifically the "ui_cancel" action.

#### Parameters

|Name|Type|Default|
|:-|:-|:-|
|`event`|`InputEvent`|-|

### pause

```gdscript
func pause() -> void
```

Pauses or resumes the game, showing or hiding the pause menu and options menu accordingly.

### _on_pause_menu_game_resume

```gdscript
func _on_pause_menu_game_resume() -> void
```

Callback function for the game resume action in the pause menu.

### _on_pause_menu_quit_to_menu

```gdscript
func _on_pause_menu_quit_to_menu() -> void
```

Callback function for the quit to menu action in the pause menu.

### _on_pause_menu_options_menu

```gdscript
func _on_pause_menu_options_menu() -> void
```

Callback function for the options menu action in the pause menu.

### _on_pause_options_back

```gdscript
func _on_pause_options_back() -> void
```

Callback function for the back action in the options menu.


