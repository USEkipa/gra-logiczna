### ----------------------------------------------------
### API for C# logger class
### ----------------------------------------------------

extends Script
class_name Logger

const INFO_MARKER = "INFO"
const ERROR_MARKER = "ERROR"
const WARNING_MARKER = "WARN"
const INFO_COLOR = "Deepskyblue"
const ERROR_COLOR = "Red"
const WARNING_COLOR = "Orange"


static func log_info(msgs: Array[Variant]) -> void:
	print_rich(_format_message(msgs, INFO_MARKER, INFO_COLOR))


static func log_error(msgs: Array[Variant]) -> void:
	var message := _format_message(msgs, ERROR_MARKER, ERROR_COLOR)
	print_rich(message)
	push_error(message)


static func log_warning(msgs: Array[Variant]) -> void:
	var message := _format_message(msgs, WARNING_MARKER, WARNING_COLOR)
	print_rich(message)
	push_warning(message)


static func _format_message(msgs: Array[Variant], marker: String, markerColor: String) -> String:
	return (
		"["
		+ _add_color(_pad_section(marker, 5), markerColor)
		+ "] : "
		+ _merge_message_to_string(msgs)
	)


static func _merge_message_to_string(msgs: Array[Variant]) -> String:
	var message := ""
	for msg in msgs:
		message += str(msg)
	return message


static func _pad_section(msg: String, length: int) -> String:
	return msg.lpad(length, " ").substr(0, length)


static func _add_color(message: String, color: String) -> String:
	return "[color=" + color + "]" + message + "[/color]"
