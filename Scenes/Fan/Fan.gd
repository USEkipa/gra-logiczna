extends Node2D

signal wind

@onready var wind_area: CollisionShape2D = $wind/CollisionShape2D
@onready var particles: CPUParticles2D = $wind/CollisionShape2D/CPUParticles2D

@export var targetDistance: float = 50.0
@export var windStrength: float = 50.0

var animation_player: AnimationPlayer
var initialParticlePosition: Vector2 = Vector2(0, 0)

var isInArea := false
var player: CharacterBody2D

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
	particles.lifetime = (targetDistance / windStrength) + 0.2

	if isInArea:
		var dir = direction.normalized()
		var target_position = global_position + dir * targetDistance

		if int(rotation_degrees) % 180 == 0:  # Fan is in a horizontal position
			player.velocity.x = dir.x * windStrength
			player.velocity.y = 0
		else:  # Fan is in a vertical position
			player.velocity.x = 0
			player.velocity.y = dir.y * windStrength
		player.move_and_slide()

		# Check if the player is in the right target position
		var distance_to_target = player.global_position.distance_to(target_position)
		var threshold = 5.0  # Adjust this threshold as needed

		if distance_to_target < threshold:
			# Player is in the right position, do something
			print("Player is in the right position")

func _on_wind_body_entered(body):
	if body is Player:
		isInArea = true
		player = body
		Globals.PlayerStats.JUMP_VELOCITY = 0
		Globals.PlayerStats.GRAVITY = 40

func _on_wind_body_exited(_body):
	isInArea = false
	Globals.PlayerStats.JUMP_VELOCITY = -300
	Globals.PlayerStats.GRAVITY = 20
