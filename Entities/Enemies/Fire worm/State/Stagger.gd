extends State


func enter():
	print("Entering Stagger State")
	animation_player.play("stagger")
	owner.velocity.x = 0

func transition():
	if not animation_player.is_playing():
		if owner.is_attacking:
			owner.state_machine.change_state("Attack")
		else:
			owner.state_machine.change_state("Idle")
