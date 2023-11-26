extends Area2D


const SPEED = 350
var direction: Vector2 = Vector2.LEFT


func _ready():
	$BulletLifeDuration.start()


func _process(delta):
	position += direction * SPEED * delta


func _on_bullet_life_duration_timeout():
	queue_free()


func _on_body_entered(body):
	print(body)
	queue_free()
