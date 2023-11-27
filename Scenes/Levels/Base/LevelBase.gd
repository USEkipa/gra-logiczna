extends Node2D
class_name LevelBase

@export var player: Player
@export var collectibles: Node2D

@onready var effects := preload("res://Scenes/Effects/Effects.tscn").instantiate()
@onready var pauseMenu: Control = $Pause/PauseMenu
@onready var optionsMenu: Control = $Pause/PauseOptions
@onready var paused: bool = false


func _ready() -> void:
	add_child(effects)
	effects.turn_on_filter(Color.CYAN, 0.05)
	effects.set_color_background(Color.BLACK)
	Sounds.play_sound(Sounds.SoundType.START_GAME)
	Sounds.play_loop_sound(Sounds.SoundType.GAME, 1)

	pauseMenu.connect("game_resume", _on_pause_menu_game_resume)
	pauseMenu.connect("quit_to_menu", _on_pause_menu_quit_to_menu)
	pauseMenu.connect("options_menu", _on_pause_menu_options_menu)

	optionsMenu.connect("back", _on_pause_options_back)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		pause()


func pause() -> void:
	paused = !get_tree().paused
	get_tree().paused = paused
	if paused:
		pauseMenu.show()
	else:
		pauseMenu.hide()
		optionsMenu.hide()


func _on_pause_menu_game_resume():
	pause()


func _on_pause_menu_quit_to_menu():
	pause()
	get_tree().change_scene_to_file("res://Scenes/UI/Menu/Main/Menu.tscn")


func _on_pause_menu_options_menu():
	pauseMenu.hide()
	optionsMenu.show()


func _on_pause_options_back():
	pauseMenu.show()
	optionsMenu.hide()
