extends Area2D
class_name HurtboxComponent

signal hit_detected(damage: int)

func _on_area_entered(area):
	if area == PlayerData.normal_attack_zone:
		emit_signal("hit_detected", PlayerData.normal_attack_damage)
	elif area == PlayerData.heavy_attack_zone:
		emit_signal("hit_detected", PlayerData.heavy_attack_damage)
	elif area.name == "projectile":
		emit_signal("hit_detected",20)
	elif area.name == "FireBall":
		emit_signal("hit_detected",20)
