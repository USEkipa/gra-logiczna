extends Node2D
class_name EnemyBase

var player: Player = null
var collectibles: Node2D = null
@onready var healthBar: TextureProgressBar = $HealthBar

var dropOnDeath: Array[PackedScene] = [preload("res://Scenes/Items/Coin/Coin.tscn")]

var stateMachine := StateMachine.new()
var enemyMovementState := EnemyMovemementState.new()

var awarnessRange: int = 100
var damage: int = 20
var maxHealthPoints: int = 100
var healthPoints: int = 100


func _ready() -> void:
	try_fetch_level_enviroment()
	enemyMovementState.set_enemy(self)

	stateMachine.add_state(enemyMovementState)
	stateMachine.add_default_state(enemyMovementState)
	stateMachine.set_state(enemyMovementState)
	_update_health_bar()


func try_fetch_level_enviroment() -> void:
	var levelBase: LevelBase = get_parent().get_parent().get_parent()
	player = levelBase.player
	collectibles = levelBase.collectibles

	if player == null:
		Logger.log_warning(["Player was not set for this enemy! Position: ", global_position])
	if collectibles == null:
		Logger.log_warning(["Collectibles was not set for this enemy! Position: ", global_position])


func take_damage(_damage: int, objectPosition: Vector2) -> void:
	healthPoints = clamp(healthPoints - _damage, 0, maxHealthPoints)
	_update_health_bar()
	if healthPoints <= 0:
		_die()


func _update_health_bar() -> void:
	healthBar.min_value = 0
	healthBar.max_value = maxHealthPoints
	healthBar.value = healthPoints


func _physics_process(delta: float) -> void:
	stateMachine.update_state_delta(delta)


func _input(event: InputEvent) -> void:
	stateMachine.update_state_input(event)


func _die() -> void:
	for packedScene in dropOnDeath:
		var item: Node2D = packedScene.instantiate()
		item.global_position = global_position
		collectibles.call_deferred("add_child", item)
	queue_free()


func _on_damage_area_area_entered(area: Area2D) -> void:
	if area is PlayerBullet:
		take_damage(area.damage, area.global_position)


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(damage, global_position)
