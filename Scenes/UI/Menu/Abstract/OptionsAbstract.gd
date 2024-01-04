extends Control
class_name Options

var toggleFullScreen: CheckButton
var toggleMusic: CheckButton
var volumeSlider: HSlider


## Function sets up buttons and sliders when menu is ready
func _ready() -> void:
	toggleFullScreen = $PanelContainer/VBoxContainer/FullScreen/toggleFullScreen
	toggleMusic = $PanelContainer/VBoxContainer/Music/toggleMusic
	volumeSlider = $PanelContainer/VBoxContainer/Volume/VolumeControls/VolumeSlider
	toggleFullScreen.button_pressed = Globals.options.isFullScreen
	toggleMusic.button_pressed = Globals.options.isMusic
	volumeSlider.value = Globals.options.volume


## Function run when `toggleFullScreen` button is pressed
##
## Function will play `BUTTON_CLICK` sound and if button is checked then the game will
## be displayed in fullscreen mode, otherwise it will revert back to the windowed mode.
func _on_toggle_full_screen_pressed() -> void:
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	if toggleFullScreen.button_pressed:
		Globals.options.isFullScreen = true
		get_tree().root.get_window().mode = Window.MODE_FULLSCREEN
	else:
		Globals.options.isFullScreen = false
		get_tree().root.get_window().mode = Window.MODE_WINDOWED


## Function run when `toggleMusic` button is pressed
##
## Function will play `BUTTON_CLICK` sound and if button is checked then the game's music 
## will be muted, otherwise the game's music volume will be reverted back to its previous state.
func _on_toggle_music_pressed() -> void:
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	Globals.options.isMusic = toggleMusic.button_pressed


## Function run when `volumeSlider's` value is changed
##
## Function will play `BUTTON_CLICK` sound and based on the slider's current value
## the game's volume will be changed.
func _on_volume_slider_value_changed(value: float) -> void:
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	Globals.options.volume = int(volumeSlider.value)
	Sounds.change_volume()


## Function run when `volumeUp` button is pressed
##
## Function will play `BUTTON_CLICK` sound and increase the game's volume by 1.
func _on_volume_up_btn_pressed() -> void:
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	volumeSlider.value += 1


## Function run when `volumeDown` button is pressed
##
## Function will play `BUTTON_CLICK` sound and decrease the game's volume by 1.
func _on_volume_down_btn_pressed() -> void:
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	volumeSlider.value -= 1
