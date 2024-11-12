extends State


@export var raycast_left_down : RayCast2D
@export var raycast_right_down: RayCast2D
@export var raycast_left : RayCast2D
@export var raycast_right : RayCast2D


func enter():
	print("Entering Warden State")

func transition():
	if owner.is_chase:
		owner.state_machine.change_state("Chase")
	else:
		check_ground_below()
		owner.movement_component.move(owner.dir, owner)
		animation_player.play("follow") 

func check_ground_below():
	if !raycast_left_down.is_colliding():
		owner.dir = Vector2.RIGHT
	elif !raycast_right_down.is_colliding():
		owner.dir = Vector2.LEFT
	elif raycast_left.is_colliding():
		owner.dir = Vector2.RIGHT
	elif raycast_right.is_colliding():
		owner.dir = Vector2.LEFT

