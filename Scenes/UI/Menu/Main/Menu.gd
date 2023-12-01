extends Control


func _ready() -> void:
	Sounds.play_loop_sound(Sounds.SoundType.MENU)
	if Globals.Options.isFullScreen:
		get_tree().root.get_window().mode = Window.MODE_FULLSCREEN


func _on_quit_pressed() -> void:
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	get_tree().quit()


func _on_options_pressed() -> void:
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	get_tree().change_scene_to_file("res://Scenes/UI/Menu/Options/OptionsMenu.tscn")


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/TestLevel.tscn")
