extends State

func enter():
	print("Entering Dead State")
	animation_player.play("death")
	owner.velocity.x = 0

func transition():
	if not animation_player.is_playing():
		PlayerData.score += 25
		owner.queue_free()
