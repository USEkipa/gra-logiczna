extends CharacterBody2D
class_name Player

const SPEED = 100
const JUMP_VELOCITY = -300
const GRAVITY = 20
const MAX_JUMPS = 1             # in case we want to add double jump


var available_jumps = MAX_JUMPS
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

func jump():
	if is_on_floor():
		available_jumps = MAX_JUMPS
	else:
		velocity.y += GRAVITY

	if Input.is_action_just_pressed("up") and available_jumps > 0:
		$Animations.play("jump")
		available_jumps -= 1

		# Scale the jump velocity based on horizontal movement speed
		velocity.y = JUMP_VELOCITY + abs(velocity.x) * 0.3



func reset_jumps():
	if is_on_floor() and available_jumps < MAX_JUMPS:
		available_jumps = MAX_JUMPS

func _input(event : InputEvent):
	if(event.is_action_pressed("ui_down") && is_on_floor()):
		position.y += 3
		
func _physics_process(_delta):
	var direction = get_direction()
	change_components_direction(direction)
	
	velocity.x = direction.x * SPEED  
	
	if direction != Vector2.ZERO:
		last_dir = direction
		if available_jumps == MAX_JUMPS:
			$Animations.play("run")
	else:
		if available_jumps == MAX_JUMPS:
			$Animations.play("idle")
	
	jump()
	move_and_slide()
	reset_jumps()
	
	if Input.is_action_pressed("shoot") and can_shoot:
		$GPUParticles2D.set_emitting(true)
		can_shoot = false
		$BulletTimer.start()
		bullet_shot.emit(get_random_marker().global_position, last_dir)

