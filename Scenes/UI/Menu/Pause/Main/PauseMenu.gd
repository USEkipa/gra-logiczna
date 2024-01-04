extends Control


signal game_resume()
signal quit_to_menu()
signal options_menu()


## Function run when `resume` button is pressed
##
## Function will playe a `BUTTON_CLICK` sound and emit a signal for resuming the game.
func _on_resume_pressed():
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	game_resume.emit()


## Function run when `quitToMenu` button is pressed
##
## Function will playe a `BUTTON_CLICK` sound and emit a signal for quitting to menu.
func _on_quit_to_menu_pressed():
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	quit_to_menu.emit()


## Function run when `options` button is pressed
##
## Function will playe a `BUTTON_CLICK` sound and emit a signal to run options menu.
func _on_options_pressed():
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	options_menu.emit()
