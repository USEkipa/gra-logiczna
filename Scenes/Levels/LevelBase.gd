extends Node2D

const bullet_scene: PackedScene = preload("res://Scenes/Projectiles/bullet.tscn")
var pause_menu: Control
var options_menu: Control
var paused: bool = false

@onready var effects := preload("res://Scenes/Effects/Effects.tscn").instantiate()

@export var PlayerScene: Player

func _ready() -> void:
	pause_menu = $Pause/PauseMenu
	options_menu = $Pause/PauseOptions
	add_child(effects)
	effects.turn_on_filter(Color.CYAN, 0.05)
	effects.set_color_background(Color.BLACK)
	Sounds.play_sound(Sounds.SoundType.START_GAME)
	Sounds.play_loop_sound(Sounds.SoundType.GAME, 1)
	PlayerScene.connect("bullet_shot", _on_player_bullet_shot)
	PlayerScene.connect("bullet_picked_up", _on_player_bullet_picked_up)
	PlayerScene.connect("coin_picked_up", _on_player_coin_picked_up)
	PlayerScene.connect("health_picked_up", _on_player_health_picked_up)
	PlayerScene.connect("damage_taken", _on_player_damage_taken)


func _on_player_bullet_shot(pos: Vector2, direction: Vector2) -> void:
	var bullet = bullet_scene.instantiate()
	bullet.rotation = direction.angle()
	bullet.direction = direction
	bullet.position = pos
	$Environment/Projectiles.add_child(bullet)
	$Environment/HUD.remove_bullet()


func _on_player_bullet_picked_up(count: int) -> void:
	$Environment/HUD.set_bullet_count(count)


func _on_player_coin_picked_up(count: int) -> void:
	$Environment/HUD.add_score(count)


func _on_player_damage_taken(count: int) -> void:
	$Environment/HUD.add_health(count)


func _on_player_health_picked_up(count: int) -> void:
	$Environment/HUD.add_health(count)


func _on_pause_menu_game_resume():
	print("AAAAA")
	pause()


func _on_pause_menu_quit_to_menu():
	pause()
	get_tree().change_scene_to_file("res://Scenes/UI/Menu/Main/Menu.tscn")


func _on_pause_menu_options_menu():
	pause_menu.hide()
	options_menu.show()


func _on_pause_options_back():
	pause_menu.show()
	options_menu.hide()
