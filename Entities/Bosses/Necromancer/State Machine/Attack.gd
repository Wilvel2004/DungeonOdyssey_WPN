extends State

@export var bullet_node: PackedScene
var can_transition : bool

func enter():
	super.enter()
	can_transition = false
	
	animation_player.play("ranged_attack")
	await animation_player.animation_finished 
	
	if owner.health >= 150:
		animation_player.play("idle")
		await  get_tree().create_timer(1.0).timeout
	else:
		animation_player.play("idle")
		await  get_tree().create_timer(0.5).timeout
	
	can_transition = true

func shoot():
	var bullet = bullet_node.instantiate()
	if sprite.flip_h:
		bullet.position = owner.position + Vector2(-20,-27)
	else:
		bullet.position = owner.position + Vector2(20,-27)
	get_tree().current_scene.add_child(bullet)

func transition():
	if  can_transition:
		get_parent().change_state("Teleport")
