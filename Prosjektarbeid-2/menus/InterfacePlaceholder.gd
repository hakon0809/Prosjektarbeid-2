extends CanvasLayer

onready var pause_menu = $PauseMenu/MarginContainer

func _ready():
	pause_menu.hide()
	

func _on_PauseButton_pressed():
	get_tree().paused = true
	pause_menu.show()


func _on_ResumeButton_pressed():
	get_tree().paused = false
	pause_menu.hide()


func _on_QuitButton_pressed():
	get_tree().quit()