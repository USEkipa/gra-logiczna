extends Node2D

signal wind

@onready var wind_area: CollisionShape2D = $wind/CollisionShape2D
@onready var particles: CPUParticles2D = $wind/CollisionShape2D/CPUParticles2D

@export var targetDistance: float = 50.0
@export var windStrength: float = 50.0

var animation_player: AnimationPlayer
var initialParticlePosition: Vector2 = Vector2(0, 0)

var isInArea := false
var bodiesInFanArea: Array[Entity] = []


func _ready() -> void:
	initialParticlePosition = particles.global_position
	animation_player = $fan/AnimationPlayer


func _physics_process(_delta) -> void:
	var direction = Vector2(cos(deg_to_rad(rotation_degrees)), sin(deg_to_rad(rotation_degrees)))
	var new_position = global_position + direction * targetDistance / 2
	var new_size = Vector2(targetDistance, wind_area.shape.extents.y * 2)

	animation_player.play("active")

	wind_area.global_position = new_position
	wind_area.shape.extents = new_size / 2

	var wind_velocity = direction * windStrength
	particles.global_position = initialParticlePosition
	particles.gravity = wind_velocity
	particles.lifetime = (targetDistance / windStrength) + 0.2

	for body in bodiesInFanArea:
		var directionNormalized = direction.normalized()
		body.velocity.x = directionNormalized.x * windStrength
		body.velocity.y = directionNormalized.y * windStrength
		body.move_and_slide()


func _on_wind_body_entered(body) -> void:
	if body is Entity:
		bodiesInFanArea.append(body)


func _on_wind_body_exited(body) -> void:
	if body is Entity:
		bodiesInFanArea.remove_at(bodiesInFanArea.find(body))
