extends Entity
class_name EnemyBase

@onready var healthBar: TextureProgressBar = $HealthBar
@onready var attackArea: AttackArea = $AttackArea
@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D

var player: Player = null
var collectibles: Node2D = null
var dropOnDeath: Array[PackedScene] = [preload("res://Scenes/Items/Coin/Coin.tscn")]

var stateMachine := StateMachine.new()
var enemyMovementState: EnemyMovemementState

var isDying := false
var isAttacking := false
var attackCooldownSeconds: float = 1
var awarnessRange: int = 100
var damage: int = 20
var animationTimer := Stoper.new()
var movementSpeed := 25


func _ready() -> void:
	try_fetch_level_enviroment()
	attackArea.targetBody = player
	attackArea.cooldownSeconds = attackCooldownSeconds
	enemyMovementState = EnemyMovemementState.new(self)

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


func take_damage(amount: int, _objectPosition: Vector2) -> void:
	super(amount, _objectPosition)
	_update_health_bar()
	if health <= 0:
		_die()


func force_animation(animationName: String, timeMs: int) -> void:
	animationTimer.reset_timer()
	animationTimer.set_cooldown(timeMs)
	animatedSprite.play(animationName)


func play_animation(animationName: String) -> void:
	if not animationTimer.is_cooldown_time_passed():
		return
	animatedSprite.play(animationName)


func _update_health_bar() -> void:
	healthBar.value = health


func _physics_process(delta: float) -> void:
	if isDying or isAttacking:
		return

	super(delta)
	stateMachine.update_state_delta(delta)


func _input(event: InputEvent) -> void:
	if isDying:
		return

	stateMachine.update_state_input(event)


func _die() -> void:
	for packedScene in dropOnDeath:
		var item: Node2D = packedScene.instantiate()
		item.global_position = global_position
		collectibles.call_deferred("add_child", item)
	queue_free()


func _on_attack_area_damage_area_entered(body: Node2D) -> void:
	if body is Player and not isDying:
		body.take_damage(damage, global_position)


func _on_attack_area_detection_area_entered(body: Node2D) -> void:
	if body is Player and not isDying:
		isAttacking = true
		_attack_preparation()


func _attack_preparation() -> void:
	Logger.log_warning(["_attack_preparation should be overwritten"])


func _on_attack_area_detection_finished(_body: Node2D) -> void:
	isAttacking = false
