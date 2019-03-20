extends CanvasLayer

onready var pause_menu = $PauseMenu
var paused

func _ready():
	pause_menu.hide()
	paused = false

func _on_PauseButton_pressed():
	if paused:
		get_tree().paused = false
		paused = false
		pause_menu.hide()
	else:
		get_tree().paused = true
		paused = true
		pause_menu.show()


func _on_ResumeButton_pressed():
	get_tree().paused = false
	paused = false
	pause_menu.hide()


func _on_QuitButton_pressed():
	get_tree().quit()