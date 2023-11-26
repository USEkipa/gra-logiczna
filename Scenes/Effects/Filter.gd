extends CanvasLayer

@onready var colorRect: ColorRect = $Control/ColorRect


func turn_on_filter(color: Color, alpha: float = 1.0) -> void:
	alpha = clampf(alpha, 0.0, 1.0)
	color.a = alpha
	colorRect.color = color
	show()
