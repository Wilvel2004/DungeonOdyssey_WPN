extends CharacterBody2D

#Nodes
@onready var state_machine = $FiniteStateMachine
@onready var movement_component = $Components/MovementComponent
@onready var health_component = $Components/HealthComponent
@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

var is_attacking: bool = false
var dir: Vector2 = Vector2.ZERO
var player : CharacterBody2D

func _process(delta):
	movement_component.apply_gravity(delta, self)
	
	player = PlayerData.playerBody
	
	state_machine.current_state._physics_process(delta)
	
	dir = player.position - position
	
	if dir.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	move_and_slide()

func take_damage(damage):
	state_machine.change_state("Stagger")
	health_component.take_damage(damage)
	if health_component.is_dead():
		state_machine.change_state("Death")

func _on_hit_detected(damage):
	take_damage(damage)

func _on_player_detected(player):
	self.player = player
	is_attacking = true

func _on_player_lost(player):
	if player == self.player:
		self.player = null
		is_attacking = false
		if !state_machine.current_state.name == "Death":
			state_machine.change_state("Idle")
