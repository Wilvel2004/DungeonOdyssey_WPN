extends Node
class_name MovementComponent

@export var speed : float = 15.0
@export var gravity : float = 900.0

func apply_gravity(delta: float,body : CharacterBody2D):
	if not body.is_on_floor():
		body.velocity.y += gravity * delta

func move(direction: Vector2,body : CharacterBody2D):
	body.velocity.x = direction.x * speed 
