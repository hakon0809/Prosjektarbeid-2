extends CanvasLayer

onready var number = $Control/HUD/HPContainer/Background/MarginContainer/HBoxContainer/Number
onready var bar = $Control/HUD/HPContainer/TextureProgress

onready var pause_menu = $Control/PauseMenu
var paused


func _ready():
	var player_max_health = get_tree().get_root().get_node("Node/Player/KinematicBody2D").max_health
	bar.max_value = player_max_health
	pause_menu.hide()
	paused = false

func _on_KinematicBody2D_health_changed(player_health):
	bar.value = player_health
	number.text = str(player_health)

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