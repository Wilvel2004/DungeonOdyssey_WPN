extends Area2D

class_name Door

@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = "up"
@onready var spawn = $Spawn

func _on_Portal_body_entered(body):
	if body.name == "Player":
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
		await Leaderboards.post_guest_score("dungeonodyssey-main-RzxA", PlayerData.score, PlayerData.player_name)
	pass
