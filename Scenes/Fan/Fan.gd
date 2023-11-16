extends Node2D

signal wind

@onready var wind_area: CollisionShape2D = $wind/CollisionShape2D
@onready var particles: CPUParticles2D = $wind/CollisionShape2D/CPUParticles2D


@export var targetDistance: float = 50.0
@export var windStrength: float = 100.0

var animation_player : AnimationPlayer
var initialParticlePosition: Vector2 = Vector2(0, 0)

func _ready():
	# Save the initial position of the particles
	initialParticlePosition = particles.global_position
	animation_player = $fan/AnimationPlayer

func _physics_process(_delta):
	# Calculate the new position and size of the CollisionShape2D
	var direction = Vector2.RIGHT.rotated(deg_to_rad(rotation_degrees))
	var new_position = global_position + direction * targetDistance / 2
	var new_size = Vector2(targetDistance, wind_area.shape.extents.y * 2)
	
	animation_player.play("active")
	# Update the CollisionShape2D
	wind_area.global_position = new_position
	wind_area.shape.extents = new_size / 2

	# Update particle system position
	particles.global_position = initialParticlePosition

	# Calculate the wind velocity and direction
	var wind_velocity = direction * windStrength

	# Set the particle system gravity based on wind direction
	particles.gravity = wind_velocity

	# Set particle system lifetime based on target distance
	particles.lifetime = (targetDistance / windStrength) + 0.3

	# Emit the wind signal (you can connect this signal to your Player)
	emit_signal("wind", direction)

func _on_wind_body_entered(body):
	if body is Player:
		var direction = Vector2(cos(rotation), sin(rotation))
		var target_position = body.global_position + direction * targetDistance

		if int(rotation_degrees) % 180 == 0:  # Fan is in a horizontal position
			body.velocity.x = direction.x * windStrength
			body.velocity.y = 0
		else:  # Fan is in a vertical position
			body.velocity.x = 0
			body.velocity.y = direction.y * windStrength
		var movement_speed = 0.1
		body.global_position = body.global_position.move_toward(target_position, movement_speed)
		body.move_and_slide()

		print(direction)
