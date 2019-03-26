extends Control

func _ready():
	Globals.play_song(Globals.main_menu_song)

func _on_Continue_pressed():
	get_tree().change_scene('res://menus/Continue.tscn')


func _on_newgame_pressed():
	get_tree().change_scene('res://levels/prison/prison.tscn')
	#Globals.play_song(Globals.city_song, -17)


func _on_Options_pressed():
	get_tree().change_scene('res://menus/Options.tscn')


