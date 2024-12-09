extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	if Firebase.Auth.check_auth_file():
		%StateLabel.text = "logged in"
		Persistence.load_player_settings()
		get_tree().change_scene_to_file("res://Common/UI/Menu/Main menu/MainMenu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func extract_username(email: String) -> String:
	var username = email.split("@")[0]
	return username

func save_player_name(email):
	Persistence.config.set_value("Player", "player_name", extract_username(email))
	Persistence.save_data()

func _on_login_button_pressed():
	var email = %EmailLineEdit.text
	var password = %PassLineEdit.text
	Firebase.Auth.login_with_email_and_password(email, password)
	%StateLabel.text = "Loggin in"


func _on_signup_button_pressed():
	var email = %EmailLineEdit.text
	var password = %PassLineEdit.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	%StateLabel.text = "Singing up"

func on_login_succeded(auth):
	#print(auth)
	%StateLabel.text = "Log in success"
	var email = %EmailLineEdit.text
	PlayerData.player_name = email
	save_player_name(email)
	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://Common/UI/Menu/Main menu/MainMenu.tscn")

func on_signup_succeded(auth):
	#print(auth)
	%StateLabel.text = "Sign up success"
	var email = %EmailLineEdit.text
	PlayerData.player_name = email
	save_player_name(email)
	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://Common/UI/Menu/Main menu/MainMenu.tscn")

func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	%StateLabel.text = "Log in failed. Error: %s" % message

func on_signup_failed(error_code, message):
	print(error_code)
	print(message)
	%StateLabel.text = "Sign up failed. Error: %s" % message
