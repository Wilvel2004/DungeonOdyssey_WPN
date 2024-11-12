extends Node2D

@export var ghost_node: PackedScene

@onready var duration_timer: Timer = $DashTimer
@onready var dash_again: Timer = $DashAgain
@onready var ghost_timer: Timer = $GhostTimer

var sprite: Sprite2D
var can_dash: bool = true
var dashing: bool = false

func start_dash(sprite: Sprite2D, duration: float) -> void:
	duration_timer.wait_time = duration
	duration_timer.start()
	await duration_timer.timeout
	dashing = true
	can_dash = false
	dash_again.start()

func add_ghost() -> void:
	if not ghost_node:
		print("Ghost node not set!")
		return
	var ghost = ghost_node.instantiate() as Sprite2D
	get_parent().add_child(ghost)
	ghost.global_position = sprite.global_position
	ghost.texture = sprite.texture
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h

func is_dashing() -> bool:
	return dashing

func _on_duration_timeout() -> void:
	dashing = false
	add_ghost()

func _on_dash_again_timeout() -> void:
	can_dash = true

func _on_ghost_timer_timeout() -> void:
	add_ghost()
