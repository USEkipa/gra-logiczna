extends Control



func _on_retry_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/TestLevel.tscn")


func _on_quit_to_menu_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Menu/Main/Menu.tscn")
