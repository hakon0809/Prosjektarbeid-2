extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_PumpButton_pressed():
	pass

func _on_CollectButton_pressed():
	pass
	
func explode(number):
	return randi()%number+1