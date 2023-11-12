extends Control

func _ready() -> void:
	Sounds.stop_loop_sound()
	Sounds.play_loop_sound(Sounds.SoundType.MENU)
	if Globals.Menu.isFullScreen:
		get_tree().root.get_window().mode = Window.MODE_FULLSCREEN


func _on_quit_pressed():
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	get_tree().quit()


func _on_options_pressed():
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	get_tree().change_scene_to_file("res://Scenes/UI/Menu/Options/OptionsMenu.tscn")
