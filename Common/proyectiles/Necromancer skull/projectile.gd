extends Area2D
class_name Projectile 

var player
var direction 
var speed = 250
 
func _ready():
	player = get_parent().find_child("Player")
	direction = (player.position - position).normalized()
 
func _physics_process(delta):
	position += direction * speed * delta

func mirror_flip():
	direction = Vector2 (-direction.x, -direction.y)
	set_collision_layer_value(3,true)
	set_collision_mask_value(4,true)

func _on_screen_exited():
	queue_free()
