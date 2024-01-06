extends Node2D
class_name LevelBase

## Represents the player object.
@export var player: Player
## Represents a collection of Node2D objects.
@export var collectibles: Node2D
## An instance of the "Effects" scene, preloaded and ready to be used.
@onready var effects := preload("res://Scenes/Effects/Effects.tscn").instantiate()
## A Control node representing the pause menu.
@onready var pauseMenu: Control = $Pause/PauseMenu
## A Control node representing the options menu.
@onready var optionsMenu: Control = $Pause/PauseOptions
## A boolean indicating whether the game is currently paused.
@onready var paused: bool = false


## Called when the scene is ready. Initializes various components, connects signals, and sets up the initial game state.
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


## Handles input events, specifically the "ui_cancel" action.
func _input(event: InputEvent) -> void:
	"""
	Handles input events.
	"""
	if event.is_action_pressed("ui_cancel"):
		pause()


## Pauses or resumes the game, showing or hiding the pause menu and options menu accordingly.
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


## Callback function for the game resume action in the pause menu.
func _on_pause_menu_game_resume() -> void:
	"""
	Resumes the game from the pause menu.
	"""
	pause()


## Callback function for the quit to menu action in the pause menu.
func _on_pause_menu_quit_to_menu() -> void:
	"""
	Quits to the main menu from the pause menu.
	"""
	pause()
	get_tree().change_scene_to_file("res://Scenes/UI/Menu/Main/Menu.tscn")


## Callback function for the options menu action in the pause menu.
func _on_pause_menu_options_menu() -> void:
	"""
	Displays the options menu from the pause menu.
	"""
	pauseMenu.hide()
	optionsMenu.show()


## Callback function for the back action in the options menu.
func _on_pause_options_back() -> void:
	"""
	Goes back to the pause menu from the options menu.
	"""
	pauseMenu.show()
	optionsMenu.hide()
