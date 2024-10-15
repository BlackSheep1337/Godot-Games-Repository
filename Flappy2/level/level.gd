extends Node2D

var game_running: bool
var game_over: bool
var scroll
const SCROLL_SPEED: int = 4
var screen_size: Vector2i

func _ready():
	screen_size = get_window().size
	SignalManager.bird_crashed.connect(on_bird_crashed)
	new_game()
	
func _on_reset():
	new_game()
	get_tree().reload_current_scene()
	
func new_game() -> void:
	game_running = false
	game_over = false
	scroll = 0
	$Bird.reset()
	
func on_bird_crashed() -> void:
	$Bird.game_over()
	
func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $Bird.flying:
						$Bird.flap()

#should apply pipes on this function called
#parallax function before to happens in the begin
func start_game() -> void:
	game_running = true
	$Bird.flying = true
	$Bird.flap()

func _process(_delta):
	if game_running:
		scroll += SCROLL_SPEED
		
		if $Bird.position.y  < 0:
			$Bird.position.y = 0
		
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
	$Bird.flying = false
	$Bird.game_over()
