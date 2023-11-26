extends Control


signal game_resume()
signal quit_to_menu()
signal options_menu()


func _on_resume_pressed():
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	game_resume.emit()


func _on_quit_to_menu_pressed():
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	quit_to_menu.emit()


func _on_options_pressed():
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	options_menu.emit()
