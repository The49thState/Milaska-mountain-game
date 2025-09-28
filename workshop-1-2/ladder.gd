extends Area2D

signal player_entered(player)
signal player_exited(player)

func _on_body_entered(body):
	if body.is_in_group("players"): # Add players to "players" group
		emit_signal("player_entered", body)

func _on_body_exited(body):
	if body.is_in_group("players"):
		emit_signal("player_exited", body)
