extends State

func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("idle")
	await get_tree().create_timer(1.0).timeout
 
func exit():
	super.exit()
	owner.set_physics_process(false)
 
func transition():
	var distance = owner.direction.length()
	if distance < 40:
		get_parent().change_state("MeleeAttack")
	elif distance > 200:
		get_parent().change_state("HomingMissile")
