extends State

func enter():
	print("Entering Chase State")

func transition():
	if owner.is_attacking:
		owner.state_machine.change_state("Attack")
	else:
		animation_player.play("follow") 
		var dir_to_player = owner.global_position.direction_to(player.global_position) * owner.movement_component.speed
		owner.velocity.x = dir_to_player.x
		owner.dir.x = sign(owner.velocity.x)
		owner.movement_component.move(owner.dir, owner)
