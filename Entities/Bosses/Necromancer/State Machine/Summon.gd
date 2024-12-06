extends State

@export var skeleton_node: PackedScene
var can_transition : bool

func enter():
	super.enter()
	can_transition = false
	
	animation_player.play("summon")
	await animation_player.animation_finished
	
	if owner.health >= 150:
		animation_player.play("idle")
		await  get_tree().create_timer(1.0).timeout
	else:
		animation_player.play("idle")
		await  get_tree().create_timer(0.5).timeout
	
	can_transition = true

func spawn():
	var skeleton = skeleton_node.instantiate()
	skeleton.position = owner.position + Vector2(42,60)
	get_tree().current_scene.call_deferred("add_child",skeleton)
	skeleton.resurection = true
	skeleton.is_chase = true

func transition():
	if can_transition:
		get_parent().change_state("Teleport")
