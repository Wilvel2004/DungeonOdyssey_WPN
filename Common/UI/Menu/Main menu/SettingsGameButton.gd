extends Button
 
@onready var settings = %Settings
@onready var main_menu = %MainMenu 
 
func _on_pressed():
	settings.show()
	main_menu.hide()
