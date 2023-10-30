extends Control

var toggleFullScreen: CheckButton
var toggleMusic: CheckButton
var volumeSlider: HSlider


func _ready() -> void:
	toggleFullScreen = $PanelContainer/VBoxContainer/FullScreen/toggleFullScreen
	toggleMusic = $PanelContainer/VBoxContainer/Music/toggleMusic
	volumeSlider = $PanelContainer/VBoxContainer/Volume/VolumeControls/VolumeSlider
	toggleFullScreen.button_pressed = Globals.Menu.isFullScreen
	toggleMusic.button_pressed = Globals.Menu.isMusic
	volumeSlider.value = Globals.Menu.volume


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/Menu/Main/Menu.tscn")


func _on_toggle_full_screen_pressed() -> void:
	if toggleFullScreen.button_pressed:
		Globals.Menu.isFullScreen = true
		get_tree().root.get_window().mode = Window.MODE_FULLSCREEN
	else:
		Globals.Menu.isFullScreen = false
		get_tree().root.get_window().mode = Window.MODE_WINDOWED


func _on_toggle_music_pressed() -> void:
	Globals.Menu.isMusic = toggleMusic.button_pressed


func _on_volume_slider_value_changed(value: float) -> void:
	Globals.Menu.volume = int(volumeSlider.value)


func _on_volume_up_btn_pressed() -> void:
	volumeSlider.value += 1


func _on_volume_down_btn_pressed() -> void:
	volumeSlider.value -= 1
