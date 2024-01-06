extends Entity
class_name Player

var speed := 100
var jumpVelocity := -300
var maxJumps := 1
var maxBulletCount := 10
var bulletCount := 3
var score := 0
var staggerForce := 100

signal bullet_shot

@onready var effects := preload("res://Scenes/Effects/Effects.tscn").instantiate()
@onready var hud: PlayerHUD = $HUD

var canShoot := true
var canTakeDamage := true
var fade := 0.0
var pickUpLabel: Label
var bulletTimer: Timer
var allInteractions: Array[UpgradeItemBase] = []
var stateMachine := StateMachine.new()
var playerMovementState := PlayerMovementState.new()


## Called when the scene is ready. Initializes various components and sets up the players initial state.
func _ready() -> void:
	add_child(effects)
	hud.set_player(self)
	hud.update_ui()

	playerMovementState.set_player(self)

	stateMachine.add_state(playerMovementState)
	stateMachine.add_default_state(playerMovementState)
	stateMachine.set_state(playerMovementState)

	pickUpLabel = $Press_E
	bulletTimer = $BulletTimer


## Increases the players bullet count by the specified amount.
func add_bullets(amount: int) -> void:
	Sounds.play_sound(Sounds.SoundType.GET_AMMO)
	bulletCount = clampi(bulletCount + amount, 0, maxBulletCount)
	hud.update_ui()


## Increases the players score by the specified amount.
func add_score(amount: int) -> void:
	Sounds.play_sound(Sounds.SoundType.GET_COIN)
	score += amount
	hud.update_ui()


## Handles the player taking damage, applying effects and updating the HUD.
func take_damage(amount: int, objectPosition: Vector2) -> void:
	if not canTakeDamage:
		return

	super(amount, objectPosition)
	playerMovementState.change_components_direction(-calc_stagger_direction(objectPosition))
	effects.turn_on_filter(Color.RED, 0.2)
	canTakeDamage = false
	$StaggerTimer.start()
	playerMovementState.isStaggered = true
	Sounds.play_sound(Sounds.SoundType.GET_DAMAGE)
	hud.update_ui()

	if health <= 0:
		$Animations.play("death")
		Sounds.play_sound(Sounds.SoundType.GAME_OVER)
		playerMovementState.isDead = true
	else:
		Sounds.play_sound(Sounds.SoundType.GET_DAMAGE)
		$Animations.play("stagger")


## Handles the player picking up health, updating the HUD.
func health_picked_up(count: int) -> void:
	Sounds.play_sound(Sounds.SoundType.GET_HP)
	add_health(count)
	hud.update_ui()


## Callback function when the bulletTimer expires, allowing the player to shoot again.
func _on_bullet_timer_timeout() -> void:
	canShoot = true


## Returns a random Marker2D from the BulletStartPositions node.
func get_random_marker() -> Marker2D:
	var bullet_markers = $BulletStartPositions.get_children()
	return bullet_markers[randi() % bullet_markers.size()]


## Callback function when an animation finishes, handling player state changes and effects.
func _on_animations_animation_finished() -> void:
	if playerMovementState.isStaggered:
		playerMovementState.isStaggered = false
		effects.turn_on_filter(Color.RED, 0.0)
	if playerMovementState.isDead:
		for i in range(10):
			$DeathFade.start()
			await $DeathFade.timeout
		get_tree().change_scene_to_file("res://Scenes/UI/Menu/Death/DeathMenu.tscn")


func _on_stagger_timer_timeout() -> void:
	canTakeDamage = true


func _on_death_fade_timeout() -> void:
	fade += 0.1
	effects.turn_on_filter(Color.BLACK, fade)


## Updates the visibility of the interaction prompt label based on available interactions.
func update_pickUpLabel_visibility() -> void:
	pickUpLabel.visible = true if allInteractions else false


## Adds an interaction to the list and updates the visibility of the interaction prompt label.
func add_interaction(interaction: UpgradeItemBase) -> void:
	allInteractions.insert(0, interaction)
	update_pickUpLabel_visibility()


## Removes an interaction from the list and updates the visibility of the interaction prompt label.
func erase_interaction(interaction: UpgradeItemBase) -> void:
	allInteractions.erase(interaction)
	update_pickUpLabel_visibility()


## Executes the current interaction, if available.
func execute_interaction() -> void:
	if allInteractions.is_empty():
		return
	var currentInteraction := allInteractions[0]
	if "on_execute_interaction" in currentInteraction:
		currentInteraction.on_execute_interaction(self)


## Changes the bullet timer speed based on the provided count.
func change_bulletTimer_speed(count: float) -> void:
	var newWaitTime := bulletTimer.wait_time + count
	if newWaitTime > 0:
		bulletTimer.wait_time = newWaitTime


## Handles physics-related updates, including state machine updates and interaction execution.
func _physics_process(delta: float) -> void:
	super(delta)
	stateMachine.update_state_delta(delta)

	if Input.is_action_just_pressed("interact"):
		execute_interaction()


## Handles input events, updating the state machine based on user input.
func _input(event: InputEvent) -> void:
	stateMachine.update_state_input(event)
