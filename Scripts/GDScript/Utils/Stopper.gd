extends RefCounted
class_name Stopper

var delayTime: float = 1.0
var timePassed: float= 0.0

func _init(_delayTime: float = 1.0) -> void:
	delayTime = _delayTime

func update_timer(delta: float) -> void:
	timePassed += delta
	
func is_time_passed() -> bool:
	return timePassed >= delayTime
	
func reset_timer() -> void:
	timePassed = 0.0
