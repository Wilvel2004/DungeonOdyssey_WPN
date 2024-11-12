extends State

func enter():
	print("Entering Attack State")
	var chance = randi() % 3
	match  chance:
		0:
			animation_player.play("attack")
		1:
			animation_player.play("attack2")
		2:
			animation_player.play("attack3")
	owner.velocity.x = 0

func transition():
	if animation_player.is_playing():
		return
	else:
		owner.state_machine.change_state("Chase")
