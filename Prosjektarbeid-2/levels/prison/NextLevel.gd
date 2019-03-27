extends Area2D


func _on_NextLevel_body_entered(body):
	if body.is_in_group("character"):
		print("Master has given Doby a sock!")
		get_tree().change_scene("res://levels/city/city.tscn")
		Globals.play_song(Globals.city_song, -17)
