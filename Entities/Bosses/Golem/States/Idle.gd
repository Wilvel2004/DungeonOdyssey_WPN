extends State
 
@onready var collision = $"../../PlayerDetection/CollisionShape2D"
@export var progress_bar : TextureProgressBar
 
var player_entered: bool = false:
	set(value):
		player_entered = value
		collision.set_deferred("disabled", value)
		progress_bar.set_deferred("visible",value)


func transition():
	if player_entered:
		get_parent().change_state("Follow")
 
func _on_player_detection_body_entered(body):
	player_entered = true
	particles1.emitting = true
	particles2.emitting = true
	block_door1.set_collision_layer_value(1,true)
	block_door1.set_collision_mask_value(1,true)
	block_door2.set_collision_layer_value(1,true)
	block_door2.set_collision_mask_value(1,true)
