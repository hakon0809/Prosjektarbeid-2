extends Node

var max_depth = 2000

func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		print("wiiiii")
		#change scene
		pass
