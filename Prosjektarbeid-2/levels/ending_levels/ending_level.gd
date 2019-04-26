extends Node2D



func _ready():
	Globals.play_song(Globals.ending_song)
func _on_StartArea_body_entered(body):
	if body.is_in_group("character"):
		print("her trengs det litt dialog harry")


func _on_EndArea_body_entered(body):
	if body.is_in_group("character"):
		Globals.music_player.stop()
		if Globals.data_sharing_mode == "data":
			get_tree().change_scene('res://menus/questionnaire/PostQuestionnaire.tscn')
		else:
			get_tree().change_scene("res://menus/TitleScreen.tscn")
