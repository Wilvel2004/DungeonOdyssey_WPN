extends Door

@onready var ap = $AnimationPlayer

func _ready():
	ap.play("active")

func _on_Portal_body_entered(body):
	if body.name == "Player":
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
		await Leaderboards.post_guest_score("dungeonodyssey-main-eb71", PlayerData.score, PlayerData.player_name)
	pass
