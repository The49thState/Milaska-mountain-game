extends Camera2D

@export var target: Line2D
@export var follow_speed := 5.0

func _process(delta):
	if target:
		global_position = global_position.lerp(target.global_position, delta * follow_speed)
