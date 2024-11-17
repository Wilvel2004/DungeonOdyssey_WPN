extends State
 
var can_transition: bool = false
 
func enter():
	super.enter()
	animation_player.play("glowing")
	await dash()
	can_transition = true
 
func dash():
	var dir_to_player = owner.global_position.direction_to(player.global_position) * owner.movement_component.speed
	owner.velocity.x = dir_to_player.x
	owner.dir.x = sign(owner.velocity.x)
	owner.movement_component.move(owner.dir, owner)
 
func transition():
	if can_transition:
		can_transition = false
		get_parent().change_state("Follow")
