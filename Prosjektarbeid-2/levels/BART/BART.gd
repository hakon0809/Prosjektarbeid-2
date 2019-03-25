extends Node

var rounds = 10
var max_pumps
var score = 0
var total_score = 0
var rounds_won = 0

func _ready():
	randomize()
	new_round()
	
func new_round():
	max_pumps = 32
	score = 0
	$MarginContainer/HBoxContainer/ScoreLabel.text = str(score)
	$BalloonSprite.scale = Vector2(0, 0)
	
func _on_PumpButton_pressed():
	if explode(max_pumps+1):
		rounds -= 1
		if rounds > 0:
			new_round()
	else:
		$BalloonSprite.scale += Vector2(0.2, 0.2)
		score += 1
		$MarginContainer/HBoxContainer/ScoreLabel.text = str(score)
		max_pumps -= 1

func _on_CollectButton_pressed():
	total_score += score
	$MarginContainer/HBoxContainer/TotalScoreLabel.text = str(total_score)
	rounds -= 1
	rounds_won += 1
	if rounds > 0:
		new_round()
	else:
		pass
	
func explode(number):
	return number == randi()%number+1