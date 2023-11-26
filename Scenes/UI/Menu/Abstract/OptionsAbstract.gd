extends Control
class_name Options

var toggleFullScreen: CheckButton
var toggleMusic: CheckButton
var volumeSlider: HSlider


func _ready() -> void:
	toggleFullScreen = $PanelContainer/VBoxContainer/FullScreen/toggleFullScreen
	toggleMusic = $PanelContainer/VBoxContainer/Music/toggleMusic
	volumeSlider = $PanelContainer/VBoxContainer/Volume/VolumeControls/VolumeSlider
	toggleFullScreen.button_pressed = Globals.Options.isFullScreen
	toggleMusic.button_pressed = Globals.Options.isMusic
	volumeSlider.value = Globals.Options.volume


func _on_toggle_full_screen_pressed() -> void:
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	if toggleFullScreen.button_pressed:
		Globals.Options.isFullScreen = true
		get_tree().root.get_window().mode = Window.MODE_FULLSCREEN
	else:
		Globals.Options.isFullScreen = false
		get_tree().root.get_window().mode = Window.MODE_WINDOWED


func _on_toggle_music_pressed() -> void:
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	Globals.Options.isMusic = toggleMusic.button_pressed


func _on_volume_slider_value_changed(value: float) -> void:
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	Globals.Options.volume = int(volumeSlider.value)
	Sounds.change_volume()


func _on_volume_up_btn_pressed() -> void:
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	volumeSlider.value += 1


func _on_volume_down_btn_pressed() -> void:
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	volumeSlider.value -= 1
