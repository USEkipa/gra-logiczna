extends Options


signal back()


## Function run when `back` button is pressed
##
## Function will playe a `BUTTON_CLICK` sound and emit a signal to return to the pause menu.
func _on_back_pressed():
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	back.emit()
