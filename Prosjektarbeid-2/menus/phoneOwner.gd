extends Control



func _on_MyPhone_pressed():
	# Checks if the game is running on android, else OS.get_unique_ID() results in an error 
	if Engine.has_singleton("AndroidPermissions"):
		var  id = shah256_string(OS.get_unique_ID())
		Globals.player_id = id
	get_tree().change_scene('res://levels/BART/BARTIntro.tscn')

func _on_Borrow_pressed():
	get_tree().change_scene('res://menus/Username.tscn')