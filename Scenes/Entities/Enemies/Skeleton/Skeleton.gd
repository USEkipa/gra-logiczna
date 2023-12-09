extends EnemyBase


func _ready() -> void:
	awarnessRange = 250
	attackCooldownSeconds = 0.4
	super()


func _die() -> void:
	isDying = true
	force_animation("death", 2500)
	await get_tree().create_timer(2.5).timeout
	super()


func _attack_preparation() -> void:
	force_animation("attack", int(attackCooldownSeconds) * 1000)
