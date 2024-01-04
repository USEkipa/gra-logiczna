extends Options


## Function run when `back` button is pressed
##
## Function will change the current scene for the `MainMenu`.
func _on_back_pressed():
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	get_tree().change_scene_to_file("res://Scenes/UI/Menu/Main/Menu.tscn")
