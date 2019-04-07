extends Area2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		print("She was looking kind of dumb with her finger and her thumb in the shape of an 'L' on her forehead")
		#get_tree().change_scene("???????????")
