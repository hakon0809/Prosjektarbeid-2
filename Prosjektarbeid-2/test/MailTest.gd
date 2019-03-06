extends Node




func _ready():
	pass

func _on_Button_pressed():
	OS.shell_open("mailto:tsvork@live.no?subject=Results&body=yay%0Ayay")
