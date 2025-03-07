class_name Life
extends Area2D

@onready var ap = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	ap.play("active")


func _on_body_entered(body):
	if body.name == "Player":
		ap.play("destroyed")
		PlayerData.life = PlayerData.max_life
		await ap.animation_finished
		queue_free()
