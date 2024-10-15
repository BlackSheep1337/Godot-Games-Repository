extends Node2D

var game_running: bool
var game_over: bool
var scroll
const SCROLL_SPEED: int = 4
var screen_size: Vector2i

func _ready():
	$GameOverScreen.visible = false
	screen_size = get_window().size
	SignalManager.on_reset.connect(_on_reset)
	new_game()
	
func _on_reset():
	print("reset game")
	new_game()
	get_tree().reload_current_scene()
	
func new_game() -> void:
	game_running = false
	game_over = false
	GameData.reset_score()
	scroll = 0
	$Player.reset()
	
func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $Player.flying:
						$Player.flap()

func start_game() -> void:
	game_running = true
	$Player.flying = true
	$Player.flap()

func _process(_delta):
	$Score.text = str(GameData.get_score())
	if game_running:
		scroll += SCROLL_SPEED
		
		if scroll >= screen_size.x:
			scroll = 0

func _on_pipes_spawner_hit():
	_on_hit()
	
func _on_area_2d_body_entered(_body):
	_on_hit()
	
func _on_hit() -> void:
	apply_game_over()

func apply_game_over() -> void:
	game_running = false
	game_over = true
	$Player.flying = false
	$Player.game_over()
	$GameOverScreen.visible = true
