extends Node

const scene_level1 = preload("res://Stages/Zone 1/level_1.tscn")
const scene_level1_1 = preload("res://Stages/Zone 1/level_1_1.tscn")
const scene_level1_2 = preload("res://Stages/Zone 1/level_1_2.tscn")
const scene_level1_3 = preload("res://Stages/Zone 1/level_1_3.tscn")
const scene_level1_4 = preload("res://Stages/Zone 1/level_1_4.tscn")
const scene_level1_5 = preload("res://Stages/Zone 1/level_1_5.tscn")
const scene_level1_6 = preload("res://Stages/Zone 1/level_1_6.tscn")
const scene_level2 = preload("res://Stages/Zone 2/level_2.tscn")
const scene_level2_1 = preload("res://Stages/Zone 2/level_2_1.tscn")
const scene_level2_1_1 = preload("res://Stages/Zone 2/level_2_1_1.tscn")
const scene_level2_1_2 = preload("res://Stages/Zone 2/level_2_1_2.tscn")
const scene_level2_1_3 = preload("res://Stages/Zone 2/level_2_1_3.tscn")
const scene_level2_2 = preload("res://Stages/Zone 2/level_2_2.tscn")
const scene_level2_2_1 = preload("res://Stages/Zone 2/level_2_2_1.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"level_1":
			scene_to_load = scene_level1
		"level_1_1": 
			scene_to_load = scene_level1_1
		"level_1_2":
			scene_to_load = scene_level1_2
		"level_1_3":
			scene_to_load = scene_level1_3
		"level_1_4":
			scene_to_load = scene_level1_4
		"level_1_5":
			scene_to_load = scene_level1_5
		"level_1_6":
			scene_to_load = scene_level1_6
		"level_2":
			scene_to_load = scene_level2
		"level_2_1":
			scene_to_load = scene_level2_1
		"level_2_1_1":
			scene_to_load = scene_level2_1_1
		"level_2_1_2":
			scene_to_load = scene_level2_1_2
		"level_2_1_3":
			scene_to_load = scene_level2_1_3
		"level_2_2":
			scene_to_load = scene_level2_2
		"level_2_2_1":
			scene_to_load = scene_level2_2_1
	if scene_to_load != null:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position,direction)
