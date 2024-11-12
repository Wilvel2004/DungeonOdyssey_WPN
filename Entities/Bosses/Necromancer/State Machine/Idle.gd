extends State

@export var progress_bar : TextureProgressBar

var player_entered: bool = false:
	set(value):
		player_entered = value
 
func _on_player_entered(_body):
	player_entered = true
	progress_bar.visible = true
 
func transition():
	if player_entered:
		get_parent().change_state("Teleport")
