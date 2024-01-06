extends Node2D
class_name LevelBase

## Variables:
- **player**: Represents the player object.
- **collectibles**: Represents a collection of Node2D objects.
- **effects**: An instance of the "Effects" scene, preloaded and ready to be used.
- **pauseMenu**: A Control node representing the pause menu.
- **optionsMenu**: A Control node representing the options menu.
- **paused**: A boolean indicating whether the game is currently paused.
@export var player: Player
@export var collectibles: Node2D
@onready var effects := preload("res://Scenes/Effects/Effects.tscn").instantiate()
@onready var pauseMenu: Control = $Pause/PauseMenu
@onready var optionsMenu: Control = $Pause/PauseOptions
@onready var paused: bool = false

## Function: `_ready()`
- **Description**: Called when the scene is ready. Initializes various components, connects signals, and sets up the initial game state.
- **Actions**:
  - Adds the "effects" node as a child with a black background color.
  - Plays start and game loop sounds.
  - Connects signals for the pause menu and options menu actions.
func _ready() -> void:
	"""
    Called when the node is added to the scene.
    """
	add_child(effects)
	effects.set_color_background(Color.BLACK)
	Sounds.play_sound(Sounds.SoundType.START_GAME)
	Sounds.play_loop_sound(Sounds.SoundType.GAME, 1)

	pauseMenu.connect("game_resume", _on_pause_menu_game_resume)
	pauseMenu.connect("quit_to_menu", _on_pause_menu_quit_to_menu)
	pauseMenu.connect("options_menu", _on_pause_menu_options_menu)

	optionsMenu.connect("back", _on_pause_options_back)

## Function: `_input(event: InputEvent)`
- **Description**: Handles input events, specifically the "ui_cancel" action.
- **Parameters**:
  - `event`: The InputEvent object containing information about the input event.
- **Actions**:
  - Calls the `pause()` function when the "ui_cancel" action is pressed.
func _input(event: InputEvent) -> void:
	"""
    Handles input events.
    """
	if event.is_action_pressed("ui_cancel"):
		pause()

## Function: `pause()`
- **Description**: Pauses or resumes the game, showing or hiding the pause menu and options menu accordingly.
- **Actions**:
  - Toggles the `paused` variable.
  - Sets the tree paused state.
  - Shows the pause menu if paused, hides the pause menu and options menu if resumed.

func pause() -> void:
	"""
    Pauses or resumes the game.
    """
	paused = !get_tree().paused
	get_tree().paused = paused
	if paused:
		pauseMenu.show()
	else:
		pauseMenu.hide()
		optionsMenu.hide()

## Function: `_on_pause_menu_game_resume()`
- **Description**: Callback function for the game resume action in the pause menu.
- **Actions**:
  - Calls the `pause()` function.
func _on_pause_menu_game_resume() -> void:
	"""
    Resumes the game from the pause menu.
    """
	pause()

## Function: `_on_pause_menu_quit_to_menu()`
- **Description**: Callback function for the quit to menu action in the pause menu.
- **Actions**:
  - Calls the `pause()` function.
  - Changes the scene to the main menu.
func _on_pause_menu_quit_to_menu() -> void:
	"""
    Quits to the main menu from the pause menu.
    """
	pause()
	get_tree().change_scene_to_file("res://Scenes/UI/Menu/Main/Menu.tscn")

## Function: `_on_pause_menu_options_menu()`
- **Description**: Callback function for the options menu action in the pause menu.
- **Actions**:
  - Hides the pause menu.
  - Shows the options menu.
func _on_pause_menu_options_menu() -> void:
	"""
    Displays the options menu from the pause menu.
    """
	pauseMenu.hide()
	optionsMenu.show()

## Function: `_on_pause_options_back()`
- **Description**: Callback function for the back action in the options menu.
- **Actions**:
  - Shows the pause menu.
  - Hides the options menu.
func _on_pause_options_back() -> void:
	"""
    Goes back to the pause menu from the options menu.
    """
	pauseMenu.show()
	optionsMenu.hide()
