extends Node
class_name State

@onready var player = owner.get_parent().find_child("Player")
@onready var animation_player = owner.find_child("AnimationPlayer")
@onready var sprite = owner.find_child("Sprite2D")
@onready var particles1 = owner.get_parent().find_child("Particles1")
@onready var particles2 = owner.get_parent().find_child("Particles2")
@onready var block_door1 = owner.get_parent().find_child("S1")
@onready var block_door2 = owner.get_parent().find_child("S2")

func _ready():
	set_physics_process(false)

func enter():
	set_physics_process(true)

func exit():
	set_physics_process(false)

func transition():
	pass

func _physics_process(delta):
	transition()
