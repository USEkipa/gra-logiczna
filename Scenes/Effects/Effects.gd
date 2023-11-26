extends Node2D

@onready var filter: CanvasLayer = $Filter
@onready var background: CanvasLayer = $BG


func set_color_background(color: Color) -> void:
	background.set_color_background(color)


func turn_on_filter(color: Color, alpha: float = 1.0) -> void:
	filter.turn_on_filter(color, alpha)
