extends Area2D

@onready var ap = $AnimationPlayer

func _ready():
	ap.play("active")

func _on_Portal_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Common/UI/Final/FinalScreen.tscn")
		await Leaderboards.post_guest_score("dungeonodyssey-main-eb71", PlayerData.score, PlayerData.player_name)
	pass
