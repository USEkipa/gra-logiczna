extends Node2D

signal wind
const MAX_WIND_SPEED = 100

var baseWindStrenght: int = Globals.World.GRAVITY
@export var windStrength: int = 10

var animation_player: AnimationPlayer
var characterBodiesInFanArea: Array[CharacterBody2D] = []
var rigidBodiesInFanArea: Array[RigidBody2D] = []
var direction: Vector2


func _ready() -> void:
	animation_player = $fan/AnimationPlayer
	animation_player.play("active")

	direction = (
		Vector2(cos(deg_to_rad(rotation_degrees)), sin(deg_to_rad(rotation_degrees))).normalized()
	)


func _physics_process(_delta) -> void:
	for body in characterBodiesInFanArea:
		body.velocity += direction * get_wind_strenght()

	for body in rigidBodiesInFanArea:
		body.apply_central_impulse(direction * get_wind_strenght())


func _on_wind_body_entered(body) -> void:
	if body is CharacterBody2D:
		characterBodiesInFanArea.append(body)
	if body is RigidBody2D:
		rigidBodiesInFanArea.append(body)
	if body is CharacterBody2D:
		characterBodiesInFanArea.append(body)
	if body is RigidBody2D:
		rigidBodiesInFanArea.append(body)


func _on_wind_body_exited(body) -> void:
	if body is CharacterBody2D:
		characterBodiesInFanArea.remove_at(characterBodiesInFanArea.find(body))
	if body is RigidBody2D:
		rigidBodiesInFanArea.remove_at(rigidBodiesInFanArea.find(body))


func get_wind_strenght() -> int:
	return windStrength + baseWindStrenght
