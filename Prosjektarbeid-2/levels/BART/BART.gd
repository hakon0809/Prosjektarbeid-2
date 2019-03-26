extends Node

var rounds = 10
var max_pumps
var score = 0
var total_score = 0
var rounds_won = 0

func _ready():
	randomize()
	$PanelContainer/MarginContainer/VBoxContainer.hide()
	new_round()
	get_tree().get_root().get_node("Globals").sound_player.stop()
		
func new_round():
	$PanelContainer/MarginContainer/Popup.hide()
	$PanelContainer/MarginContainer/HBoxContainer2.show()
	$PanelContainer/BalloonSprite.texture = load("res://levels/BART/balloon_red.png")
	max_pumps = 32
	score = 0
	rounds -= 1
	$PanelContainer/MarginContainer/HBoxContainer/ScoreLabel.text = str(score)
	$PanelContainer/BalloonSprite.scale = Vector2(0.5, 0.5)
	$PanelContainer/BalloonSprite.rotation_degrees = 0
	
func finish():
	if rounds_won > 0:
		var aggregate = total_score / rounds_won
		get_tree().get_root().get_node("Globals").set_bart_score(total_score, aggregate)
	$PanelContainer/BalloonSprite.texture = null
	$PanelContainer/MarginContainer/Popup.hide()
	$PanelContainer/MarginContainer/HBoxContainer.hide()
	$PanelContainer/MarginContainer/HBoxContainer2.hide()
	$PanelContainer/MarginContainer/VBoxContainer/ScoreLabel.text = str(total_score)
	$PanelContainer/MarginContainer/VBoxContainer.show()
	
func _on_PumpButton_pressed():
	if explode(max_pumps+1):
		$PanelContainer/BalloonSprite.texture = null
		$PanelContainer/MarginContainer/Popup.show()
		$PanelContainer/MarginContainer/HBoxContainer2.hide()
	else:
		$PanelContainer/BalloonSprite.scale += Vector2(0.02, 0.02)
		rotate_balloon()
		score += 1
		$PanelContainer/MarginContainer/HBoxContainer/ScoreLabel.text = str(score)
		max_pumps -= 1

func _on_CollectButton_pressed():
	if score > 0:
		total_score += score
		$PanelContainer/MarginContainer/HBoxContainer/TotalScoreLabel.text = str(total_score)
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

func _on_NextButton_pressed():
	pass # replace with function body


func explode(number):
	return number == randi()%number+1

func rotate_balloon():
	if randi()%3+1 == 1:
		$PanelContainer/BalloonSprite.rotation_degrees = randi()%6+1
	else:
		$PanelContainer/BalloonSprite.rotation_degrees = -(randi()%6+1)