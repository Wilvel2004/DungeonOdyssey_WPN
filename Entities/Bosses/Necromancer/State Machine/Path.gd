extends State

var can_transition : bool
var tp_dir : bool = true
var teleport_count : int = 0
var max_teleports : int = 2

func enter():
	super.enter()
	can_transition = false
	
	animation_player.play("skill")
	await animation_player.animation_finished
	
	can_transition = true

func teleport():
	if tp_dir:
		owner.position = owner.position + Vector2(125,0)
	else:
		owner.position = owner.position + Vector2(-125,0)

	teleport_count += 1
	
	if teleport_count >= max_teleports:
		tp_dir = not tp_dir
		teleport_count = 0  

func transition():
	var distance = owner.direction.length()
	if can_transition:
		if distance < 50:
			get_parent().change_state("Summon")
		elif distance > 130:
			get_parent().change_state("Attack")
