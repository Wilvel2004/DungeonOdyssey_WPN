extends State

var player_entered: bool = false:
	set(value):
		player_entered = value

func enter():
	print("Entering Resurection State")

func transition():
	if player_entered or owner.resurection:
		animation_player.play("resurection")
		await animation_player.animation_finished
		get_parent().change_state("Warden")


func _on_player_detected(player):
	player_entered = true
