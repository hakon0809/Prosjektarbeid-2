extends Node

var rounds = 5
var max_pumps = 10
var score = 0

func _ready():
	randomize()
	new_round()
	
func new_round():
	max_pumps = 10
	score = 0
	
func _on_PumpButton_pressed():
	if max_pumps == explode(max_pumps):
		rounds -= 1
		new_round()
	else:
		score += 1
		max_pumps -= 1

func _on_CollectButton_pressed():
	new_round()
	
func explode(number):
	return randi()%number+1