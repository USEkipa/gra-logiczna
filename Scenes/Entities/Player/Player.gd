extends Entity
class_name Player

var speed := 100
var jumpVelocity := -300
var maxJumps := 1
var pushForce := 20
var maxBulletCount := 10
var bulletCount := 3
var score := 0

signal bullet_shot

@onready var hud: PlayerHUD = $HUD

var canShoot := true
var pickUpLabel: Label
var bulletTimer: Timer
var allInteractions: Array[UpgradeItemBase] = []
var stateMachine := StateMachine.new()
var playerMovementState := PlayerMovementState.new()


func _ready() -> void:
	hud.set_player(self)
	hud.update_ui()

	playerMovementState.set_player(self)

	stateMachine.add_state(playerMovementState)
	stateMachine.add_default_state(playerMovementState)
	stateMachine.set_state(playerMovementState)

	pickUpLabel = $Press_E
	bulletTimer = $BulletTimer


func add_bullets(count: int) -> void:
	Sounds.play_sound(Sounds.SoundType.GET_AMMO)
	bulletCount = clampi(bulletCount + count, 0, maxBulletCount)
	hud.update_ui()


func add_score(count: int) -> void:
	Sounds.play_sound(Sounds.SoundType.GET_COIN)
	score += count
	hud.update_ui()


func take_damage(count: int) -> void:
	Sounds.play_sound(Sounds.SoundType.GET_DAMAGE)
	add_health(-count)
	hud.update_ui()


func health_picked_up(count: int) -> void:
	Sounds.play_sound(Sounds.SoundType.GET_HP)
	add_health(count)
	hud.update_ui()


func _on_bullet_timer_timeout() -> void:
	canShoot = true


func get_random_marker() -> Marker2D:
	var bullet_markers = $BulletStartPositions.get_children()
	return bullet_markers[randi() % bullet_markers.size()]


# INTERACTIONS --------------------------------------------------
func update_pickUpLabel_visibility() -> void:
	pickUpLabel.visible = true if allInteractions else false


func add_interaction(interaction: UpgradeItemBase) -> void:
	allInteractions.insert(0, interaction)
	update_pickUpLabel_visibility()


func erase_interaction(interaction: UpgradeItemBase) -> void:
	allInteractions.erase(interaction)
	update_pickUpLabel_visibility()


func execute_interaction() -> void:
	if allInteractions.is_empty():
		return
	var currentInteraction := allInteractions[0]
	if "on_execute_interaction" in currentInteraction:
		currentInteraction.on_execute_interaction(self)


func change_bulletTimer_speed(count: float) -> void:
	var newWaitTime := bulletTimer.wait_time + count
	if newWaitTime > 0:
		bulletTimer.wait_time = newWaitTime


func _physics_process(delta: float) -> void:
	stateMachine.update_state_delta(delta)

	if Input.is_action_just_pressed("interact"):
		execute_interaction()


func _input(event: InputEvent) -> void:
	stateMachine.update_state_input(event)
