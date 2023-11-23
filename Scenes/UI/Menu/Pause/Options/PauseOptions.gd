extends Options


signal back()


func _on_back_pressed():
	Sounds.play_sound(Sounds.SoundType.BUTTON_CLICK)
	back.emit()
