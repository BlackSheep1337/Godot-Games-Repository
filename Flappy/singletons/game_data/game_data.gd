extends Node

var _score: int = 0
var _best_score: int = 0

func get_score() -> int:
	return _score

func set_score(val: int) -> void:
	_score += val
	if _score >= _best_score:
		_best_score = _score

func reset_score() -> void:
	_score = 0

func get_best_score() -> int:
	return _best_score
