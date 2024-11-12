extends CharacterBody2D
class_name Player

# Constants
const MAX_SPEED : float = 150.0
const DASH_SPEED : float = 400.0
const DASH_LENGHT : float = .5
const COYOTE_TIME : float = 0.2
const JUMP_BUFFER_TIME  : float = 0.1
const JUMP_HEIGHT : float = 100.0
const JUMP_TIME_TO_PEAK : float = 0.5
const JUMP_TIME_TO_DESCENT : float = 0.4
const ATTACK_WAIT_TIME : float = 0.7
#States
enum  player_states {
	MOVE,
	ATTACK, 
	HEAVY_ATTACK,
	HIT, 
	DEAD
}

#Variables
var standing_cshape = preload("res://Utilities/Player cshape/player_standing_cshape.tres")
var crouching_cshape = preload("res://Utilities/Player cshape/player_crouching_cshape.tres")
var is_crouching : bool = false
var stuck_under_object : bool = false

var jump_velocity : float = ((2.0 * JUMP_HEIGHT) / JUMP_TIME_TO_PEAK)
var jump_gravity : float = ((2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_PEAK * JUMP_TIME_TO_PEAK))
var fall_gravity : float = ((2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_DESCENT * JUMP_TIME_TO_DESCENT))

var current_state = player_states.MOVE
var coyote_timer : float = 0.0
var jump_buffer_timer : float = 0.0
var attack_wait_timer : float = 0.0
var can_double_jump = true
var can_dash : bool  = true
var is_dashing : bool = false
var can_take_damage : bool = true

#Exported nodes
@export var ghost_node : PackedScene

#Nodes
@onready var dash_particles = $GPUParticles2D
@onready var ghost_timer = $GhostTimer
@onready var dash_timer = $DashTimer
@onready var wait_timer = $WaitTimer
@onready var jump_height_timer = $JumpHeightTimer
@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var cshape = $PlayerCshape
@onready var crouch_raycast1 = $CrouchRayCast_1
@onready var crouch_raycast2 = $CrouchRayCast_2
@onready var attackCollision = $AttackArea2D/AttackCollisionShape
@onready var heavyAttackCollision = $HeavyAttackArea2D/HeavyAttackCollisionShape

func _ready():
	PlayerData.playerBody = self
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	can_take_damage = true

func _on_spawn(position: Vector2, direction: String):
	global_position = position
	ap.play("run"+direction)
	ap.stop()

func _physics_process(delta):
	PlayerData.normal_attack_zone = $AttackArea2D
	PlayerData.heavy_attack_zone = $HeavyAttackArea2D
	PlayerData.playerHitbox = $InteractionArea
	
	# Update timers
	if is_on_floor():
		coyote_timer = COYOTE_TIME
		can_double_jump = true
	else:
		coyote_timer -= delta

	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta
	
	if attack_wait_timer > 0:
		attack_wait_timer -= delta
	
	match current_state:
		player_states.MOVE:
			hanlde_move_state(delta)
		player_states.ATTACK:
			handle_normal_attack_state()
		player_states.HEAVY_ATTACK:
			handle_heavy_attack_state()
		player_states.HIT:
			handle_hit_state()
		player_states.DEAD:
			handle_dead_state()
	
	if PlayerData.life <= 0:
		current_state = player_states.DEAD


func hanlde_move_state(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += get_gravity() * delta
	
	#Jump
	if Input.is_action_just_pressed("up_move"):
		jump_buffer_timer = JUMP_BUFFER_TIME
	if (coyote_timer > 0 or is_on_floor()) and jump_buffer_timer > 0 and above_head_is_empety():
		jump_height_timer.start()
		jump()
		print("Jump")
		jump_buffer_timer = 0
	if Input.is_action_just_pressed("up_move") and can_double_jump and !is_on_floor() and coyote_timer <= 0 and PlayerData.has_doublejump:
		double_jump()
		print("DoubleJump")
	
	#Dash
	if Input.is_action_just_pressed("dash") and can_dash and PlayerData.has_dash:
		dash(DASH_LENGHT)
	
	#Velocity and direction
	var horizontal_direction = Input.get_axis("left_move", "right_move")
	
	if horizontal_direction != 0:
		switch_direction(horizontal_direction)
	
	if is_dashing:
		velocity.x = horizontal_direction * DASH_SPEED
	else:
		velocity.x = horizontal_direction * MAX_SPEED
		ghost_timer.stop()
		dash_particles.emitting = false
	
	#Crounch
	if Input.is_action_just_pressed("down_move"):
		crouch()
		position.y += 1
	elif Input.is_action_just_released("down_move"):
		if  above_head_is_empety():
			stand()
		else:
			if stuck_under_object != true:
				stuck_under_object = true
	if stuck_under_object && above_head_is_empety():
		if !Input.is_action_just_pressed("down_move"):
			stand()
			stuck_under_object = false
	
	if Input.is_action_just_pressed("attack_key")and attack_wait_timer <= 0 and above_head_is_empety():
		current_state = player_states.ATTACK
		attack_wait_timer = ATTACK_WAIT_TIME
	
	if Input.is_action_just_pressed("heavy_attack_key") and attack_wait_timer <= 0 and above_head_is_empety():
		current_state = player_states.HEAVY_ATTACK
		attack_wait_timer = ATTACK_WAIT_TIME
	
	move_and_slide()
	update_animation(horizontal_direction)

func handle_normal_attack_state():
	ap.play("normal_attack_NoMovement")

func handle_heavy_attack_state():
	ap.play("heavy_attack_NoMovemet")

func handle_hit_state():
	ap.play("hit")

func handle_dead_state():
	PlayerData.alive = false
	velocity.x = 0
	ap.play("dead")
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	PlayerData.life = 4
	PlayerData.alive = true
	if get_tree():
		get_tree().reload_current_scene()

func get_gravity():
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y -= jump_velocity

func double_jump():
	velocity.y -= jump_velocity 
	can_double_jump = false

func crouch():
	if is_crouching:
		return
	is_crouching = true
	cshape.shape = crouching_cshape
	cshape.position.y = -11

func stand():
	if is_crouching == false:
		return
	is_crouching = false
	cshape.shape = standing_cshape
	cshape.position.y = -16

func above_head_is_empety() -> bool:
	var result = !crouch_raycast1.is_colliding() && !crouch_raycast2.is_colliding()
	return result

func add_ghost():
	var ghost = ghost_node.instantiate()
	ghost.set_property(
	position + Vector2(0,-37),
	sprite.scale,
	sprite.flip_h,
	sprite.texture,
	sprite.frame,
	sprite.hframes
	)
	get_tree().current_scene.add_child(ghost)

func dash(dur):
	ghost_timer.start()
	dash_particles.emitting = true
	
	can_dash = false
	is_dashing = true
	
	dash_timer.wait_time = dur
	dash_timer.start()
	await dash_timer.is_stopped()
	
	wait_timer.start()

func take_damage(damage):
	if !PlayerData.parry:
		PlayerData.life -= damage
		current_state = player_states.HIT
		take_damage_cooldown(1.0)

func take_damage_cooldown(wait_time):
	can_take_damage = false
	await  get_tree().create_timer(wait_time).timeout
	can_take_damage = true

func update_animation(horizontal_direction):
	if is_on_floor():
		if horizontal_direction == 0:
			if is_crouching:
				ap.play("crouch")
			else:
				ap.play("idle")
		else:
			if is_crouching:
				ap.play("crouch_walk")
			elif is_dashing:
				ap.play("dash")
			else:
				ap.play("run")
	else:
		if velocity.y < 0:
			ap.play("jump")
		elif is_dashing:
			ap.play("dash")
		elif  velocity.y > 0:
			ap.play("fall")

func switch_direction(horizontal_direction):
	sprite.flip_h = (horizontal_direction == -1)
	sprite.position.x = horizontal_direction * 4
	if(horizontal_direction == -1):
		attackCollision.position.x = -25
		heavyAttackCollision.position.x = -25
	else:
		attackCollision.position.x = 25
		heavyAttackCollision.position.x = 25

func reset_state():
	current_state = player_states.MOVE

func _on_ghost_timer_timeout():
	add_ghost()

func _on_dash_timer_timeout():
	is_dashing = false

func _on_wait_timer_timeout():
	can_dash = true

func _on_jump_height_timer_timeout():
	if !Input.is_action_pressed("up_move"):
		if velocity.y < -100:
			velocity.y = -100

func _on_interaction_area_entered(area):
	if area.name == "SkeletonDealDamage" and can_take_damage:
		take_damage(0.5)
	elif area.name == "HmaDealDamage" and can_take_damage:
		take_damage(1)
	elif area.name == "DealDamage" and can_take_damage :
		take_damage(1)
	elif area.name == "projectile" and can_take_damage:
		take_damage(2)
	elif area.name == "FireBall" and can_take_damage:
		take_damage(1)
