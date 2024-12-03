extends Area2D
  
@onready var animated_sprite = $AnimatedSprite2D
@onready var player = get_parent().find_child("Player")

var direction 
var speed = 200

func _ready():
	direction = (player.position - position).normalized()
	
	if direction.x < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false

func _physics_process(delta):
	position += direction * speed * delta

func mirror_flip():
	animated_sprite.flip_h = true
	direction = Vector2 (-direction.x, -direction.y)
	set_collision_layer_value(3,true)
	set_collision_mask_value(4,true)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
