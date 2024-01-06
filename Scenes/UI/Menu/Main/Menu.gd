extends Control


## Function will start playing the background music and based on settings
## change the size of a game's window when menu is ready.
func _ready() -> void:
	Sounds.play_loop_sound(Sounds.SoundType.MENU)
	if Globals.options.isFullScreen:
		get_tree().root.get_window().mode = Window.MODE_FULLSCREEN


## Function run when `quit` button is pressed
##
## Function will stop all processes and quit the game.
func _on_quit_pressed() -> void:
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	get_tree().quit()


## Function run when `options` button is pressed
##
## Function will change the current scene for the `OptionsMenu`.
func _on_options_pressed() -> void:
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	get_tree().change_scene_to_file("res://Scenes/UI/Menu/Options/OptionsMenu.tscn")


## Function run when `newGame` button is pressed
##
## Function will change the current scene for the `levelOne`.
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/TestLevel.tscn")
