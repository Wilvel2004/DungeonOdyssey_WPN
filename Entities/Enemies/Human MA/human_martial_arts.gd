extends CharacterBody2D

#Nodes
@onready var damage_zone = $Components/HmaDealDamage/CollisionShape2D
@onready var dect_damage_zone = $Components/HitboxComponent/CollisionShape2D
@onready var state_machine = $FiniteStateMachine
@onready var movement_component = $Components/MovementComponent
@onready var health_component = $Components/HealthComponent

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer

var is_chase: bool = false
var is_attacking: bool = false
var dir: Vector2 = Vector2.ZERO
var player : CharacterBody2D

func _process(delta):
	movement_component.apply_gravity(delta, self)
	
	player = PlayerData.playerBody
	
	state_machine.current_state._physics_process(delta)
	
	update_damage_zone_position()
	
	if dir.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	move_and_slide()

func choose(array):
	array.shuffle()
	return array.front()

func take_damage(damage):
	state_machine.change_state("Stagger")
	health_component.take_damage(damage)
	if health_component.is_dead():
		state_machine.change_state("Death")

func update_damage_zone_position():
	if dir.x == -1:
		damage_zone.position.x = -30
		dect_damage_zone.position.x = -30
	else:
		damage_zone.position.x = 30
		dect_damage_zone.position.x = 30

func _on_hit_detected(damage):
	take_damage(damage)

func _on_player_detected(player):
	self.player = player
	is_chase = true

func _on_player_lost(player):
	if player == self.player:
		self.player = null
		is_chase = false
		if !state_machine.current_state.name == "Death":
			state_machine.change_state("Warden")

func _on_damage_zone_entered():
	is_attacking = true

func _on_damage_zone_exited():
	is_attacking = false

func _on_timer_timeout():
	$Timer.wait_time = choose([1.5, 2.0, 2.5])
	if !is_chase:
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
