extends CanvasLayer

onready var number = $Control/HUD/HPContainer/Background/MarginContainer/HBoxContainer/Number
onready var bar = $Control/HUD/HPContainer/TextureProgress

onready var pause_menu = $Control/PauseMenu
var paused


func _ready():
	pause_menu.hide()
	paused = false

func _on_KinematicBody2D_health_changed(player_health):
	bar.value = player_health
	number.text = str(player_health)
	
func set_health_bar(max_health):
	bar.max_value = max_health
	$Control/HUD/HPContainer/Background/MarginContainer/HBoxContainer/Number.set_text(str(max_health))
	if max_health > 10:
		bar.texture_under = preload("res://ui/interface/lifebar_bg_upgrade_half.png")
		bar.texture_progress = preload("res://ui/interface/lifebar_fill_upgrade_half.png")
	else:
		bar.texture_under = preload("res://ui/interface/lifebar_bg_half.png")
		bar.texture_progress = preload("res://ui/interface/lifebar_fill_half.png")

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