extends Area2D


@onready var particles = $GPUParticles2D



func _on_body_entered(body):
	if body.name == "Player":
		particles.emitting = true
		PlayerData.has_dash = true
		particles.emitting = false
		queue_free()
	else:
		PlayerData.has_dash = false
