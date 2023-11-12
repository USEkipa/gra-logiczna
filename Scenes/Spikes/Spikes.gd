extends Area2D

func _on_body_entered(body):
	if body is Player:
		Sounds.play_sound(Sounds.SoundType.GAME_OVER)
		get_tree().reload_current_scene()
