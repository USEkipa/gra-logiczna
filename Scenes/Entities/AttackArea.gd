extends Node2D
class_name AttackArea

@onready var detectionArea: Area2D = $DetectionArea
@onready var detectionCollider: CollisionShape2D = $DetectionArea/CollisionShape2D
@onready var damageArea: Area2D = $DamageArea
@onready var damageCollider: CollisionShape2D = $DamageArea/CollisionShape2D

signal damage_area_entered(body: Node2D)
signal detection_area_entered(body: Node2D)
signal detection_finished(body: Node2D)

var cooldownSeconds := 1.0
var damageTimeSeconds := 0.5
var targetBody: Node2D


func _ready() -> void:
	damageArea.remove_child(damageCollider)


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body == targetBody and not damageCollider.is_inside_tree():
		emit_signal("detection_area_entered", body)
		await get_tree().create_timer(cooldownSeconds).timeout
		add_damage_collider()

		await get_tree().create_timer(damageTimeSeconds).timeout
		emit_signal("detection_finished", body)
		remove_damage_collider()

		remove_detection_collider()
		add_detection_collider()


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body == targetBody and damageCollider.is_inside_tree():
		emit_signal("damage_area_entered", body)
		remove_damage_collider()


func add_damage_collider() -> void:
	if not damageCollider.is_inside_tree():
		damageArea.add_child(damageCollider)


func remove_damage_collider() -> void:
	if damageCollider.is_inside_tree():
		damageArea.remove_child(damageCollider)


func add_detection_collider() -> void:
	if not detectionCollider.is_inside_tree():
		detectionArea.add_child(detectionCollider)


func remove_detection_collider() -> void:
	if detectionCollider.is_inside_tree():
		detectionArea.remove_child(detectionCollider)
