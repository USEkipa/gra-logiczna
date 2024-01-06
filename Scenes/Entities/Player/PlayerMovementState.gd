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


## Function used on initial configuration of the player's movement state
func set_player(_player: Player) -> void:
	player = _player
	gpuPlayerParticles = _player.get_node("GPUParticles2D")
	playerAnimations = _player.get_node("Animations")
	bulletStartPosition = _player.get_node("BulletStartPositions")
	attackArea = _player.get_node("MeleeAttackArea")
	attackAreaCollision = _player.get_node("MeleeAttackArea/CollisionShape2D")
	avaibleJumps = player.maxJumps


## Function changes player's components direction
##
## Based on the player's movement direction the components such as animations,
## gpu particles, and bullet starting positions are flipped.
##
## Params:
##
## `direction`: `Vector2`		player's movement direction
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


## Function changes gets the player's movement direction
##
## Based on input key, the direction can be changed to `left`, `right` or `zero` when
## none of the directional keys are pressed.
##
## Return:
##
## `direction`: `Vector2`		player's movement direction
func get_direction() -> Vector2:
	if Input.is_action_pressed("left"):
		return Vector2.LEFT
	if Input.is_action_pressed("right"):
		return Vector2.RIGHT
	return Vector2.ZERO


## Function responsible for managing jumping
##
## If jump key is pressed and the player has at least one jump avaible then 
## function will play `jump` animation and set a new y velocity. Otherwise
## if player is not on the floor then the function will play `fall` animation.
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


## Function responsible for managing running
##
## Function will check the movement direction of the player and if it is `zero`,
## then the `idle` animation is going to be played, otherwise the `run` animation
## is going to be played.
##
## Params:
##
## `direction`: `Vector2`		player's movement direction
func runManager(direction: Vector2) -> void:
	change_components_direction(direction)
	player.velocity.x = direction.x * player.speed
	if direction != Vector2.ZERO:
		if avaibleJumps == player.maxJumps and not isMeleeAttacking:
			playerAnimations.play("run")
	else:
		if avaibleJumps == player.maxJumps and not isMeleeAttacking:
			playerAnimations.play("idle")


## Function responsible for managing shooting
##
## If shoot button is pressed and the player is able to shoot then function will
## start emitting particles and will also emit a signal for rednering a bullet.
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


## Function responsible for managing melee attack
##
## If attack button is pressed and the player is able to attack then function will
## playe `ATTACK` sound and start a countdown for the next attack.
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


## Function responsible for resetting avaible jumps
##
## If player is on the floor and at least one jump has been used, then
## the function will reset avaible jumps back to it's maximum value.
func reset_jumps() -> void:
	if player.is_on_floor() and avaibleJumps < player.maxJumps:
		avaibleJumps = player.maxJumps


## Function responsible for letting player go down from the platforms
##
## Params:
##
## `event`: `InputEvent`		key pressed
func update_input(event: InputEvent) -> void:
	if not isDead:
		if event.is_action_pressed("down") && player.is_on_floor():
			player.position.y += 3


## Function responsible for putting together all of the movement functionality
##
## Function puts together all of the movement functionality and also
## adds a stagger time when player is being hit.
##
## Params:
##
## `_delta`: `float`		delta time since previous frame
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
