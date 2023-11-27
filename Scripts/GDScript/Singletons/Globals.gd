extends Node

var World: Dictionary = {GRAVITY = 20}

var Options: Dictionary = {
	isFullScreen = false,
	isMusic = false,
	volume = 5,
}

var PlayerStats: Dictionary = {}

var DefaultPlayerStats: Dictionary = {
	SPEED = 100,
	JUMP_VELOCITY = -300,
	GRAVITY = 20,
	MAX_JUMPS = 1,
	PUSH_FORCE = 20,
	maxBulletCount = 10,
	maxHealth = 100,
	bulletCount = 0,
	score = 0,
	health = 0,
}


func _enter_tree() -> void:
	set_default_stats()


func set_default_stats() -> void:
	PlayerStats = DefaultPlayerStats.duplicate(true)
	print(PlayerStats)
