extends StateMachineState
class_name PlayerMovementState

var player: Player = null
var gpuPlayerParticles: GPUParticles2D = null
var playerAnimations: AnimatedSprite2D = null
var bulletStartPosition: Node2D = null
var attackArea: Area2D = null
var attackAreaCollision: CollisionShape2D = null
var isStaggered: bool = false
var isDead: bool = false
var avaibleJumps: int
var lastDirection = Vector2.LEFT
var isMeleeAttacking: bool = false
var currentAttackAnimation: String = "attack1"

var attackTimer := Stopwatch.new()

func set_player(_player: Player) -> void:
	player = _player
	gpuPlayerParticles = _player.get_node("GPUParticles2D")
	playerAnimations = _player.get_node("Animations")
	bulletStartPosition = _player.get_node("BulletStartPositions")
	attackArea = _player.get_node("MeleeAttackArea")
	attackAreaCollision = _player.get_node("MeleeAttackArea/CollisionShape2D")
	avaibleJumps = player.maxJumps


func change_components_direction(direction) -> void:
	if direction == Vector2.LEFT:
		gpuPlayerParticles.position = Vector2(
			-abs(gpuPlayerParticles.position.x), gpuPlayerParticles.position.y)
		gpuPlayerParticles.process_material.direction = Vector3(-1, 0, 0)
		playerAnimations.flip_h = false
		attackAreaCollision.position.x = -abs(attackAreaCollision.position.x)
		attackAreaCollision.scale.x = -1
		for marker in bulletStartPosition.get_children():
			marker.position.x = -abs(marker.position.x)
		lastDirection = Vector2.LEFT
	elif direction == Vector2.RIGHT:
		gpuPlayerParticles.position = Vector2(
			abs(gpuPlayerParticles.position.x), gpuPlayerParticles.position.y)
		gpuPlayerParticles.process_material.direction = Vector3(1, 0, 0)
		playerAnimations.flip_h = true
		attackAreaCollision.position.x = abs(attackAreaCollision.position.x)
		attackAreaCollision.scale.x = 1
		for marker in bulletStartPosition.get_children():
			marker.position.x = abs(marker.position.x)
		lastDirection = Vector2.RIGHT


func get_direction() -> Vector2:
	if Input.is_action_pressed("left"):
		return Vector2.LEFT
	if Input.is_action_pressed("right"):
		return Vector2.RIGHT
	return Vector2.ZERO


func jumpManager() -> void:
	if Input.is_action_just_pressed("up") and avaibleJumps > 0:
		Sounds.play_sound(Sounds.SoundType.JUMP)
		if not isMeleeAttacking:
			playerAnimations.play("jump")
		avaibleJumps -= 1
		player.velocity.y = player.jumpVelocity + abs(player.velocity.x) * 0.3
	elif not player.is_on_floor():
		player.simulate_gravity()
		if player.velocity.y >= 0 and not isMeleeAttacking:
			playerAnimations.play("fall")


func runManager(direction: Vector2) -> void:
	change_components_direction(direction)
	player.velocity.x = direction.x * player.speed
	if direction != Vector2.ZERO:
		if avaibleJumps == player.maxJumps and not isMeleeAttacking:
			playerAnimations.play("run")
	else:
		if avaibleJumps == player.maxJumps and not isMeleeAttacking:
			playerAnimations.play("idle")


func shootingManager() -> void:
	if (
		Input.is_action_pressed("shoot")
		and player.canShoot
		and player.bulletCount > 0
	):
		Sounds.play_sound(Sounds.SoundType.START_GAME) # zmienić to
		gpuPlayerParticles.set_emitting(true)
		player.canShoot = false
		player.get_node("BulletTimer").start()
		player.bullet_shot.emit(player.get_random_marker().global_position, lastDirection)
		player.add_bullets(-1)

func meleeAttackManager() -> void:
	if Input.is_action_just_pressed("attack") and attackTimer.is_time_passed(1.5):
		if currentAttackAnimation == "attack1":
			currentAttackAnimation = "attack2"
		else:
			currentAttackAnimation = "attack1"

		isMeleeAttacking = true
		Sounds.play_sound(Sounds.SoundType.ATTACK)
		attackTimer.reset_timer()
		playerAnimations.play(currentAttackAnimation)
		attackAreaCollision.disabled = true

func reset_jumps() -> void:
	if player.is_on_floor() and avaibleJumps < player.maxJumps:
		avaibleJumps = player.maxJumps


func update_input(event: InputEvent) -> void:
	if not isDead:
		if event.is_action_pressed("down") && player.is_on_floor():
			player.position.y += 3


func update_delta(_delta: float) -> void:
	if not isDead:
		var direction = get_direction()
		if not isStaggered:
			runManager(direction)
			jumpManager()
			shootingManager()
			meleeAttackManager()
			if isMeleeAttacking:
				var current_frame = playerAnimations.get_frame()
				if current_frame == 2:
					attackAreaCollision.disabled = false
				else:
					attackAreaCollision.disabled = true

				if not playerAnimations.is_playing():
					isMeleeAttacking = false
					attackAreaCollision.disabled = true
		if isStaggered:
			player.velocity.x = -lastDirection.x * player.staggerForce
			isMeleeAttacking = false
			attackAreaCollision.disabled = true
		player.move_and_slide()
		reset_jumps()
