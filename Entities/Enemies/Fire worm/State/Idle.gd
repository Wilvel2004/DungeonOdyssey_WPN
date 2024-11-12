extends State

 
func enter():
	print("Entering Idle State")
 
func transition():
	if owner.is_attacking:
		owner.state_machine.change_state("Attack")
	else:
		animation_player.play("idle")
