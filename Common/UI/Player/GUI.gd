extends CanvasLayer

const HEART_ROW_SIZE = 8
const HEART_OFFSET = 16

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in PlayerData.PLAYER_LIFE:
		var new_heart = Sprite2D.new()
		new_heart.texture = $player_life.texture
		new_heart.hframes = $player_life.hframes
		$player_life.add_child(new_heart)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$coin_number.text = var_to_str(PlayerData.coin)
	display_heart()

func display_heart():
	for heart in $player_life.get_children():
		var index = heart.get_index()
		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET
		heart.position  = Vector2(x , y)
		
		var last_heart = floor(PlayerData.life)
		if index > last_heart:
			heart.frame = 0
		if index == last_heart:
			heart.frame = (PlayerData.life - last_heart) * 4
		if index < last_heart:
			heart.frame = 4
