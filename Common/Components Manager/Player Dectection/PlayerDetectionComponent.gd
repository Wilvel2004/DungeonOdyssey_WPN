extends Area2D
class_name PlayerDetectionComponent

signal player_detected(player: CharacterBody2D)
signal player_lost(player: CharacterBody2D)

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("player_detected", body)

func _on_body_exited(body):
	if body.name == "Player":
		emit_signal("player_lost", body)
