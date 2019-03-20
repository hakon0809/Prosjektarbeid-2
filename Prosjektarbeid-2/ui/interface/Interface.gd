extends CanvasLayer

onready var number = $Control/HBoxContainer/MarginContainer/Background/Number
onready var bar = $Control/HBoxContainer/TextureProgress

func _ready():
	var player_max_health = $"../KinematicBody2D".max_health
	bar.max_value = player_max_health


func _on_KinematicBody2D_health_changed(player_health):
	bar.value = player_health
	number.text = str(player_health)
