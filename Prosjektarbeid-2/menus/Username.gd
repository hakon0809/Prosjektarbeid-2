extends Control
var username = null

func _on_OkButton_pressed():
	if username != null:
		# Checks if the game is running on android, else OS.get_unique_ID() results in an error 
		if Engine.has_singleton("AndroidPermissions"):
			print("ho")
			var id = str(OS.get_unique_id(), username)
			id = id.shah256_string()
		
		get_tree().change_scene('res://menus/questionnaire/PreQuestionnaire.tscn')


func _on_username_field_text_changed(new_text):
	username = new_text
