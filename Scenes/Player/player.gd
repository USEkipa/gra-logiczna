extends CharacterBody2D


const SPEED = 300
const JUMP_VELOCITY = -1500
const ACC = 50
const FRICTION = 70
const GRAVITY = 100
const MAX_JUMPS = 1                # in case we want to add double jump


var avaible_jumps = MAX_JUMPS
var last_dir = Vector2.LEFT
var can_shoot = true


signal bullet_shot(pos, direction)


func _on_bullet_timer_timeout():
	can_shoot = true


func get_random_marker() -> Marker2D:
	var bullet_markers = $BulletStartPositions.get_children()
	return bullet_markers[randi() % bullet_markers.size()]


func change_components_direction(direction):
	if direction == Vector2.LEFT:
		$GPUParticles2D.position = Vector2(-abs($GPUParticles2D.position.x), $GPUParticles2D.position.y)
		$GPUParticles2D.process_material.direction = Vector3(-1, 0, 0)
		$Animations.flip_h = false
		for marker in $BulletStartPositions.get_children():
			marker.position.x = -abs(marker.position.x)
	elif direction == Vector2.RIGHT:
		$GPUParticles2D.position = Vector2(abs($GPUParticles2D.position.x), $GPUParticles2D.position.y)
		$GPUParticles2D.process_material.direction = Vector3(1, 0, 0)
		$Animations.flip_h = true
		for marker in $BulletStartPositions.get_children():
			marker.position.x = abs(marker.position.x)


func get_direction() -> Vector2:
	if Input.is_action_pressed("left"):
		return Vector2.LEFT
	if Input.is_action_pressed("right"):
		return Vector2.RIGHT
	return Vector2.ZERO


func accelerate(direction):
	velocity = velocity.move_toward(direction * SPEED, ACC)


func apply_friction():
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION)


func jump():
	if Input.is_action_just_pressed("up") and avaible_jumps > 0:
		$Animations.play("jump")
		avaible_jumps -= 1
		velocity.y = JUMP_VELOCITY
	elif not is_on_floor():
		velocity.y += GRAVITY
		if velocity.y >= 0:
			$Animations.play("fall")


func reset_jumps():
	if is_on_floor() and avaible_jumps < MAX_JUMPS:
		avaible_jumps = MAX_JUMPS


func _physics_process(_delta):
	var direction = get_direction()
	change_components_direction(direction)
	if direction != Vector2.ZERO:
		last_dir = direction
		accelerate(direction)
		if avaible_jumps == MAX_JUMPS:
			$Animations.play("run")
	else:
		apply_friction()
		if avaible_jumps == MAX_JUMPS:
			$Animations.play("idle")
	jump()
	move_and_slide()
	reset_jumps()
	if Input.is_action_pressed("shoot") and can_shoot:
		$GPUParticles2D.set_emitting(true)
		can_shoot = false
		$BulletTimer.start()
		bullet_shot.emit(get_random_marker().global_position, last_dir)
