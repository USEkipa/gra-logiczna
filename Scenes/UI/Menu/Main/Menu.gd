extends Control


func _ready() -> void:
	if Globals.Menu.isFullScreen:
		get_tree().root.get_window().mode = Window.MODE_FULLSCREEN


func _on_quit_pressed():
	get_tree().quit()


func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Menu/Options/OptionsMenu.tscn")
