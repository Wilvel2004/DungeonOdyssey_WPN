extends State

@onready var rune = preload("res://Entities/Objects/Rune/rune_dash.tscn")

func enter():
	super.enter()
	animation_player.play("death")
	
	var current_scene = get_tree().current_scene
	
	for child in current_scene.get_children():
		if child.name.begins_with("skeleton") or child.name.begins_with("@CharacterBody2D@"):
			child.dead = true
	await animation_player.animation_finished 
	
	var rune_dash = rune.instantiate()
	rune_dash.position = owner.position
	get_tree().current_scene.call_deferred("add_child",rune_dash)
	
	particles1.emitting = false
	particles2.emitting = false
	
	block_door1.set_collision_layer_value(1,false)
	block_door1.set_collision_mask_value(1,false)
	block_door2.set_collision_layer_value(1,false)
	block_door2.set_collision_mask_value(1,false)
	
	PlayerData.score += 250
	
	owner.queue_free()
