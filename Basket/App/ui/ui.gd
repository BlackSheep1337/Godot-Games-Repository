extends Control
@onready var progress_bar = $HealthBar/ProgressBar
@onready var count_down_timer = $countDownTimer
@onready var score_label = $Node/ScoreLabel

var _score: int = 0
var _damage_taken: int = 200
var _game_count_down: int = 120
var _timer_accumulator: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	score_label.text = ":  " + str(_score)
	count_down_timer.text = str(_game_count_down)
	progress_bar.value = _damage_taken	
	SignalManager.on_get_hit.connect(on_hit_get_point)
	SignalManager.on_damage_taken.connect(on_damage_taken)
	
func _process(delta):
	count_down(delta)

func on_hit_get_point(point: int) -> void:
	_score += point
	score_label.text = ":  " + str(_score)

func count_down(delta: float) -> void:
	_timer_accumulator += delta
	if _timer_accumulator >= 1:
		_timer_accumulator -= 1
		_game_count_down -= 1
		SignalManager.on_timer_tick.emit(_game_count_down)
		count_down_timer.text = str(_game_count_down)

func on_damage_taken(damage: int) -> void:
	_damage_taken -= damage
	progress_bar.value = _damage_taken
