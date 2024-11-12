extends State

func enter():
	print("Entering Attack State")
	animation_player.play("attack")
	owner.velocity.x = 0

func transition():
	if animation_player.is_playing():
		return
	else:
		owner.state_machine.change_state("Chase")
