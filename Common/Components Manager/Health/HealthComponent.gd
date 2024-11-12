extends Node
class_name HealthComponent

@export var health_max : int = 30
var health : int
var dead : bool = false 

func _ready():
	health = health_max

func take_damage(damage: int):
	health -= damage
	if health <= 0:
		health = 0
		dead = true

func is_dead() -> bool:
	return dead
