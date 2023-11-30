extends CharacterBody2D
class_name Player

const bullet_scene: PackedScene = preload("res://Scenes/Projectiles/bullet.tscn")

signal bullet_shot

@onready var hud: PlayerHUD = $HUD
@onready var effects := preload("res://Scenes/Effects/Effects.tscn").instantiate()

var can_shoot = true

var press_e_label: Label
var bullet_timer: Timer
var all_interactions = []
var can_take_damage = true
var stateMachine := StateMachine.new()
var playerMovementState := PlayerMovementState.new()


func _ready() -> void:
	playerMovementState.set_player(self)
	add_child(effects)
	stateMachine.add_state(playerMovementState)
	stateMachine.add_default_state(playerMovementState)
	stateMachine.set_state(playerMovementState)

	press_e_label = $Press_E
	bullet_timer = $BulletTimer


func bullet_picked_up(count: int) -> void:
	Sounds.play_sound(Sounds.SoundType.GET_AMMO)
	$HUD.set_bullet_count(count)


func coin_picked_up(count: int) -> void:
	Sounds.play_sound(Sounds.SoundType.GET_COIN)
	$HUD.add_score(count)


func calc_stagger_direction(enemyPosition: Vector2):
	var dir = global_position.x - enemyPosition.x
	if dir >= 0:
		return Vector2.RIGHT
	if dir < 0:
		return Vector2.LEFT


func take_damage(count: int, objectPosition: Vector2) -> void:
	if can_take_damage:
		playerMovementState.change_components_direction(-calc_stagger_direction(objectPosition))
		effects.turn_on_filter(Color.RED, 0.2)
		can_take_damage = false
		$Animations.play("stagger")
		$StaggerTimer.start()
		playerMovementState.isStaggered = true
		Sounds.play_sound(Sounds.SoundType.GET_DAMAGE)
		$HUD.add_health(-count)


func health_picked_up(count: int) -> void:
	Sounds.play_sound(Sounds.SoundType.GET_HP)
	$HUD.add_health(count)


func _on_bullet_timer_timeout():
	can_shoot = true


func get_random_marker() -> Marker2D:
	var bullet_markers = $BulletStartPositions.get_children()
	return bullet_markers[randi() % bullet_markers.size()]


func _on_animations_animation_finished():
	if playerMovementState.isStaggered:
		playerMovementState.isStaggered = false
		effects.turn_on_filter(Color.CYAN, 0.0)


func _on_stagger_timer_timeout():
	can_take_damage = true


# INTERACTIONS --------------------------------------------------
func update_press_e_label_visibility() -> void:
	if all_interactions:
		press_e_label.visible = true
	else:
		press_e_label.visible = false


func add_interaction(interaction: UpgradeItemBase) -> void:
	all_interactions.insert(0, interaction)
	update_press_e_label_visibility()


func erase_interaction(interaction: UpgradeItemBase) -> void:
	all_interactions.erase(interaction)
	update_press_e_label_visibility()


func execute_interaction() -> void:
	if all_interactions:
		var current_interaction = all_interactions[0]
		if "on_execute_interaction" in current_interaction:
			current_interaction.on_execute_interaction(self)


func change_bullet_timer_speed(count: float) -> void:
	var new_wait_time = bullet_timer.wait_time + count
	if new_wait_time > 0:
		bullet_timer.wait_time = new_wait_time


func _physics_process(delta: float) -> void:
	stateMachine.update_state_delta(delta)

	if Input.is_action_just_pressed("interact"):
		execute_interaction()


func _input(event: InputEvent) -> void:
	stateMachine.update_state_input(event)
