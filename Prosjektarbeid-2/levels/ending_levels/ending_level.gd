extends Node2D



func _on_StartArea_body_entered(body):
	if body.is_in_group("character"):
		print("her trengs det litt dialog harry")


func _on_EndArea_body_entered(body):
	if body.is_in_group("character"):
		print("Fædi kom og tørk")
