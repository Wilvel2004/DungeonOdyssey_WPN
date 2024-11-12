extends Button


@onready var star_level = load("res://Stages/Zone 1/level_1.tscn") as PackedScene


func _on_pressed():
	get_tree().change_scene_to_packed(star_level)
