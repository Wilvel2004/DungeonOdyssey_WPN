extends State

var can_transition : bool
var tp_dir : bool = true
var teleport_count : int = 0
var max_teleports : int = 2

func _enter_tree():
	randomize()

func enter():
	super.enter()
	can_transition = false
	
	animation_player.play("skill")
	await animation_player.animation_finished
	
	if owner.health >= 150:
		animation_player.play("idle")
		await  get_tree().create_timer(1.0).timeout
	else:
		animation_player.play("idle")
		await  get_tree().create_timer(0.5).timeout
	
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
	if can_transition:
		var chance = randi() % 2
		match  chance:
			0:
				get_parent().change_state("Summon")
			1:
				get_parent().change_state("Attack")
