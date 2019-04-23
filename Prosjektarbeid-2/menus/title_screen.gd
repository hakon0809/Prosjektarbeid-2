extends Control

func _ready():
	if !Globals.music_player.is_playing():
		Globals.play_song(Globals.main_menu_song)

func _on_Continue_pressed():
	get_tree().change_scene('res://menus/Continue.tscn')


func _on_newgame_pressed():
	#get_tree().change_scene('res://levels/prison/prison.tscn')
	#Globals.play_song(Globals.city_song, -17)
	get_tree().change_scene('res://menus/questionnaire/Questionnaire.tscn')


func _on_Options_pressed():
	get_tree().change_scene('res://menus/Options.tscn')


