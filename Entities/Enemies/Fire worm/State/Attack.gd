extends State

@export var bullet_node: PackedScene

func enter():
	print("Entering Attack State")
	animation_player.play("ranged_attack")

func shoot():
	var bullet = bullet_node.instantiate()
	bullet.position = owner.position
	get_tree().current_scene.add_child(bullet)

func transition():
	if animation_player.is_playing():
		return
	else:
		owner.state_machine.change_state("Idle")
