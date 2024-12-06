extends State
 
func enter():
	super.enter()
	animation_player.play("death")
	await animation_player.animation_finished
	particles1.emitting = false
	particles2.emitting = false
	block_door1.set_collision_layer_value(1,false)
	block_door1.set_collision_mask_value(1,false)
	block_door2.set_collision_layer_value(1,false)
	block_door2.set_collision_mask_value(1,false)
	owner.queue_free()
