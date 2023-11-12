extends CharacterBody2D
class_name Player

var can_shoot = true

signal bullet_shot(pos, direction)
signal bullet_picked_up(count: int)
signal coin_picked_up(count: int)
signal health_picked_up(count: int)
signal damage_taken(count: int)

var stateMachine := StateMachine.new(true)
var playerMovementState := PlayerMovementState.new()


func _ready() -> void:
	playerMovementState.set_player(self)

	stateMachine.add_state(playerMovementState)
	stateMachine.add_default_state(playerMovementState)
	stateMachine.set_state(playerMovementState)


func increase_bullet_count(count: int) -> void:
	bullet_picked_up.emit(count)


func increase_score_count(count: int) -> void:
	coin_picked_up.emit(count)


func increase_health_count(count: int) -> void:
	health_picked_up.emit(count)


func take_damage(count: int) -> void:
	damage_taken.emit(-count)


func _on_bullet_timer_timeout():
	can_shoot = true


func get_random_marker() -> Marker2D:
	var bullet_markers = $BulletStartPositions.get_children()
	return bullet_markers[randi() % bullet_markers.size()]


func _physics_process(delta: float) -> void:
	stateMachine.update_state_delta(delta)


func _input(event: InputEvent) -> void:
	stateMachine.update_state_input(event)
