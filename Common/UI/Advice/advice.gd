extends Area2D

var player = PlayerData.playerBody
@onready var label = $CanvasLayer/Label


func _on_body_entered(body):
	player = body
	label.visible = true
	print("entrado")


func _on_body_exited(body):
	player = null
	label.visible = false
	print("salido")
