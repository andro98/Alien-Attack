extends Control

@onready var score = $Score
@onready var health = $Health

func set_score_label(new_score):
	score.text = "SCORE: " + str(new_score)

func set_health_label(health_left):
	health.text = str(health_left)
