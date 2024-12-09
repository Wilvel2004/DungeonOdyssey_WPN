extends Button
 
@onready var settings = %Settings
@onready var mainMenu = %MainMenu

func _on_pressed():
	settings.hide()
	mainMenu.show()
