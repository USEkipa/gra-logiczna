extends Control


## Function run when `retry` button is pressed
##
## Function will restart the level so it can be played again.
func _on_retry_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/TestLevel.tscn")


## Function run when `quitToMenu` button is pressed
##
## Function will change the scene for the `MainMenu`.
func _on_quit_to_menu_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Menu/Main/Menu.tscn")
