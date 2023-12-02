extends Node2D

signal wind
const MAX_WIND_SPEED = 100

@onready var windArea: CollisionShape2D = $wind/CollisionShape2D
@onready var particles: CPUParticles2D = $wind/CollisionShape2D/CPUParticles2D

@export var targetDistance: float = 10
@export var windStrength: float = Globals.World.GRAVITY

var animation_player: AnimationPlayer
var initialParticlePosition: Vector2 = Vector2(0, 0)

var isInArea := false
var characterBodiesInFanArea: Array[CharacterBody2D] = []
var rigidBodiesInFanArea: Array[RigidBody2D] = []
var direction: Vector2


func _ready() -> void:
	initialParticlePosition = particles.global_position
	animation_player = $fan/AnimationPlayer
	animation_player.play("active")

	direction = (
		Vector2(cos(deg_to_rad(rotation_degrees)), sin(deg_to_rad(rotation_degrees))).normalized()
	)

	windArea.global_position += (
		direction * targetDistance
		+ direction * global_position.distance_to(windArea.global_position)
	)
	windArea.scale = Vector2(targetDistance / 2, windArea.scale.y)

	particles.global_position = initialParticlePosition
	particles.gravity = direction * windStrength
	particles.lifetime = (targetDistance / windStrength) + 0.2


func _physics_process(_delta) -> void:
	for body in characterBodiesInFanArea:
		body.velocity.y += direction.y * windStrength
		body.velocity.x += direction.x * windStrength
		body.move_and_slide()
	for body in rigidBodiesInFanArea:
		body.apply_central_impulse(direction * windStrength)


func _on_wind_body_entered(body) -> void:
	if body is CharacterBody2D:
		characterBodiesInFanArea.append(body)
	if body is RigidBody2D:
		rigidBodiesInFanArea.append(body)


func _on_wind_body_exited(body) -> void:
	if body is CharacterBody2D:
		characterBodiesInFanArea.remove_at(characterBodiesInFanArea.find(body))
	if body is RigidBody2D:
		rigidBodiesInFanArea.remove_at(rigidBodiesInFanArea.find(body))
