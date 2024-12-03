extends CharacterBody2D
 
@onready var player = CharacterBody2D
@onready var sprite = $Sprite2D
@onready var progress_bar = $UI/HealthBar
@onready var vfx = $VFX
 
var direction : Vector2
var DEF = 0
 
var health = 200:
	set(value):
		if value < health:
			vfx.play("hit")
		health = value
		progress_bar.value = health
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")
		elif value <= progress_bar.max_value / 2 and DEF == 0:
			DEF = 5
			find_child("FiniteStateMachine").change_state("ArmorBuff") 

func _ready():
	set_physics_process(false) 
 
func _process(_delta):
	player = PlayerData.playerBody
	
	direction = player.position - position
 
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)

func _on_hitbox_component_area_entered(area):
	if area == PlayerData.normal_attack_zone:
		health -= PlayerData.normal_attack_damage - DEF
	
	if area == PlayerData.heavy_attack_zone:
		health -= PlayerData.heavy_attack_damage - DEF
	
	if area.name == "GolemMissile":
		health -= 20 - DEF


