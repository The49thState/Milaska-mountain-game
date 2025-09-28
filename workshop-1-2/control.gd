extends Control

var running: bool = true
var elapsed: float = 0.0
@onready var timer_label: Label = $TimerLabel

func _process(delta: float) -> void:
	if running:
		elapsed += delta
		timer_label.text = format_time(elapsed)
func format_time(t: float) -> String:
	var total_ms := int(t * 1000.0)
	var ms := total_ms % 1000
	var total_s := total_ms / 1000
	var s := total_s % 60
	var m := (total_s / 60)
	return "%02d:%02d.%03d" % [m, s, ms]
	
	
	
func reset_timer():
	elapsed = 0.0
	
func stop_timer():
	running = false
	
func start_timer():
	running = true
	
