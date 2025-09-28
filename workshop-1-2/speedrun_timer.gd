extends Control

@export var save_file := "user://best_time.save"

var running: bool = false
var elapsed: float = 0.0    # seconds
var best_time: float = 0.0  # 0 means none saved

# Node refs
onready var timer_label: Label = $TimerLabel
onready var best_label: Label = $BestLabel

func _ready() -> void:
	load_best()
	update_labels()

func _process(delta: float) -> void:
	if running:
		elapsed += delta
		update_timer_label()

# ---- Public controls ----
func start_timer() -> void:
	if not running:
		running = true
		# Optionally reset on start
		# elapsed = 0.0
		update_timer_label()

func stop_timer(record: bool = true) -> void:
	if running:
		running = false
		update_timer_label()
		if record:
			_maybe_record_best()

func reset_timer() -> void:
	running = false
	elapsed = 0.0
	update_timer_label()

func toggle_timer() -> void:
	if running:
		stop_timer()
	else:
		start_timer()

# ---- Formatting & UI ----
func update_timer_label() -> void:
	timer_label.text = format_time(elapsed)

func update_best_label() -> void:
	if best_time > 0.0:
		best_label.text = "Best: " + format_time(best_time)
	else:
		best_label.text = "Best: --:--.---"

func update_labels() -> void:
	update_timer_label()
	update_best_label()

func format_time(t: float) -> String:
	var total_ms := int(t * 1000.0)
	var ms := total_ms % 1000
	var total_s := total_ms / 1000
	var s := total_s % 60
	var m := (total_s / 60) % 60
	# Format like MM:SS.mmm
	return str(m).pad_zero(2) + ":" + str(s).pad_zero(2) + "." + str(ms).pad_zero(3)

func _maybe_record_best() -> void:
	if elapsed <= 0.0:
		return
	if best_time == 0.0 or elapsed < best_time:
		best_time = elapsed
		save_best()
		update_best_label()

func save_best() -> void:
	var file := FileAccess.open(save_file, FileAccess.ModeFlags.WRITE)
	if file:
		file.store_32(1) # version marker (optional)
		file.store_double(best_time)
		file.close()

func load_best() -> void:
	if not FileAccess.file_exists(save_file):
		best_time = 0.0
		return
	var file := FileAccess.open(save_file, FileAccess.ModeFlags.READ)
	if file:
		best_time = file.get_double()
		file.close()
	else:
		best_time = 0.0
