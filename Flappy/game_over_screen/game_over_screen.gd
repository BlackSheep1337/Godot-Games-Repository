extends CanvasLayer

@onready var score_label = $BgOverlay/BoxContainer/ScoreLabel
@onready var best_score_label = $BgOverlay/BoxContainer/BestScoreLabel
@onready var quit_original_pos = $BgOverlay/ButtonContainer/Quit/QuitLabel.position.y
@onready var reset_original_pos = $BgOverlay/ButtonContainer/Reset/ResetLabel.position.y

var _down_position = 25

func _process(_delta):
	score_label.text = "SCORE: " + str(GameData.get_score())
	best_score_label.text = "BEST SCORE: " + str(GameData.get_best_score())

func _on_reset_button_down():
	$BgOverlay/ButtonContainer/Reset/ResetLabel.position.y = _down_position

func _on_quit_button_down():
	$BgOverlay/ButtonContainer/Quit/QuitLabel.position.y = _down_position

func _on_quit_button_up():
	$BgOverlay/ButtonContainer/Quit/QuitLabel.position.y = quit_original_pos
	get_tree().quit()
	
func _on_reset_button_up():
	$BgOverlay/ButtonContainer/Reset/ResetLabel.position.y = reset_original_pos
	SignalManager.on_reset.emit()
