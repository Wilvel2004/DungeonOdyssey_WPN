extends Area2D
class_name HitboxComponent

signal damage_zone_entered()
signal damage_zone_exited()

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("damage_zone_entered")


func _on_body_exited(body):
	if body.name == "Player":
		emit_signal("damage_zone_exited")
