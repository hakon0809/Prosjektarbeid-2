extends Control


#continue and options are inhereted scenes from newgame

func _on_Button_pressed():
	get_tree().change_scene('res://menus/TitleScreen.tscn')
