extends TabBar
 
func _ready():
	var screen_type = Persistence.config.get_value("Video","fullscreen")
	if screen_type == DisplayServer.WINDOW_MODE_FULLSCREEN:
		%FullScreen.button_pressed = true
 
	var borderless_type = Persistence.config.get_value("Video","borderless")
	if borderless_type == true:
		%Borderless.button_pressed = true
 
 
 
func _on_full_screen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Persistence.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Persistence.config.set_value("Video", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
 
	Persistence.save_data()
 
 
func _on_borderless_toggled(toggled_on):
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)
	Persistence.config.set_value("Video", "borderless", toggled_on)
	Persistence.save_data()

