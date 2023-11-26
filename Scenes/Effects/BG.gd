extends CanvasLayer

@onready var colorRect: ColorRect = $Control/ColorRect


func set_color_background(color: Color) -> void:
	colorRect.color = color
	colorRect.show()
	show()
