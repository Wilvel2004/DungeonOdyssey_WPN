extends Area2D
class_name FireBall 

@onready var sprite = $Sprite2D

var player
var direction 
var speed = 350
 
func _ready():
	sprite.visible = false
	$AnimationPlayer.play("active")
	player = get_parent().find_child("Player")
	direction = (player.position - position).normalized()
	
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
 
func _physics_process(delta):
	position += direction * speed * delta

func mirror_flip():
	sprite.flip_h = true
	direction = Vector2 (-direction.x, -direction.y)
	set_collision_layer_value(3,true)
	set_collision_mask_value(4,true)

func _on_screen_exited():
	queue_free()

func _on_timer_timeout():
	sprite.visible = true
