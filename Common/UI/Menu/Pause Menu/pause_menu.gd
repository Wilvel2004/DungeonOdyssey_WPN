extends Control

@onready var ap = $AnimationPlayer

var mainMenu = load("res://Common/UI/Menu/Main menu/MainMenu.tscn")

func _process(delta):
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()

func resume():
	get_tree().paused = false
	ap.play_backwards("blur")

func pause():
	get_tree().paused = true
	ap.play("blur")

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()
