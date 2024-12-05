extends State

@export var progress_bar : TextureProgressBar

var player_entered: bool = false:
	set(value):
		player_entered = value
 
func _on_player_entered(_body):
	player_entered = true
	progress_bar.visible = true
	particles1.emitting = true
	particles2.emitting = true
	block_door1.set_collision_layer_value(1,true)
	block_door1.set_collision_mask_value(1,true)
	block_door2.set_collision_layer_value(1,true)
	block_door2.set_collision_mask_value(1,true)
 
func transition():
	if player_entered:
		get_parent().change_state("Teleport")
