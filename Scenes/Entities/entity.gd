extends CharacterBody2D
class_name Entity

var maxHealth: int = 100
var health: int = 100


func add_health(amount: int) -> void:
	health = clampi(health + amount, 0, maxHealth)


func take_damage(amount: int) -> void:
	health = clampi(health - amount, 0, maxHealth)