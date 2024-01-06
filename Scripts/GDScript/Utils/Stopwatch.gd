extends RefCounted
class_name Stopwatch

var _startTimeMs: int
var cooldownTimeMs: int


func _init() -> void:
	reset_timer()


func is_cooldown_time_passed() -> bool:
	return (Time.get_ticks_msec() - _startTimeMs) > cooldownTimeMs


func is_time_passed(timeMs: float) -> bool:
	return (Time.get_ticks_msec() - _startTimeMs) > timeMs


func set_cooldown(timeMs: int) -> void:
	cooldownTimeMs = timeMs


func reset_timer() -> void:
	_startTimeMs = Time.get_ticks_msec()
