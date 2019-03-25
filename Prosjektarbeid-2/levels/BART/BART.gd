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
	$MarginContainer/Popup.hide()
	$MarginContainer/HBoxContainer2.show()
	max_pumps = 32
	score = 0
	rounds -= 1
	$MarginContainer/HBoxContainer/ScoreLabel.text = str(score)
	$BalloonSprite/Animation.play("Idle")
	$BalloonSprite.scale = Vector2(1, 1)
	$BalloonSprite.rotation_degrees = 0
	
func finish():
	if rounds_won > 0:
		var aggregate = total_score / rounds_won
		get_tree().get_root().get_node("Globals").set_bart_score(aggregate)
	get_tree().quit()
	
func _on_PumpButton_pressed():
	if explode(max_pumps+1):
		$BalloonSprite/Animation.play("explode")
		$MarginContainer/Popup.show()
		$MarginContainer/HBoxContainer2.hide()
	else:
		$BalloonSprite.scale += Vector2(0.1, 0.1)
		rotate_balloon()
		score += 1
		$MarginContainer/HBoxContainer/ScoreLabel.text = str(score)
		max_pumps -= 1

func _on_CollectButton_pressed():
	if score > 0:
		total_score += score
		$MarginContainer/HBoxContainer/TotalScoreLabel.text = str(total_score)
		rounds_won += 1
		if rounds > 0:
			new_round()
		else:
			finish()
	
func _on_OKButton_pressed():
	if rounds > 0:
		new_round()
	else:
		finish()

func explode(number):
	return number == randi()%number+1

func rotate_balloon():
	if $BalloonSprite.rotation_degrees < 0:
		$BalloonSprite.rotation_degrees = randi()%11+1
	else:
		$BalloonSprite.rotation_degrees = -(randi()%11+1)
		

