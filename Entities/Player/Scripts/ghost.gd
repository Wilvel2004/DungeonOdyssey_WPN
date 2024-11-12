extends Sprite2D
 
func _ready():
	await get_tree().create_timer(0.3).timeout
	queue_free()
 
func set_property(tx_pos, tx_scale, tx_flip, tx_sprit, tx_frame, tx_hframes ):
	position = tx_pos
	scale = tx_scale
	flip_h = tx_flip
	texture = tx_sprit
	frame = tx_frame
	hframes = tx_hframes
