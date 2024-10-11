extends Control

@onready var score = $Score
@onready var life_amount = $LifeAmount

func set_score_label(new_score):
	score.text = "SCORE: " + str(new_score)

func set_life_label(new_life):
	life_amount.text = str(new_life)
