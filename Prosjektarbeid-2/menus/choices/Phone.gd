extends Node

onready var PrivacyChoice = preload("res://menus/choices/PrivacyChoice.tscn")
onready var PrivacyInfo = preload("res://menus/choices/PrivacyInfo.tscn")
onready var PrivacySetting = preload("res://menus/choices/PrivacySettings.tscn")
onready var display = $Container/Sprite/Container
var level
var scale = 0.02
var opening = true

onready var sprite = $Container/Sprite

func _process(delta):
	if opening:
		if scale < 0.5:
			sprite.set_scale(Vector2(scale, scale))
			scale += 0.02
	else:
		if scale > 0:
			sprite.set_scale(Vector2(scale, scale))
			scale -= 0.02
		else:
			self.queue_free()

func _ready():
	sprite.set_scale(Vector2(0, 0))
	
func choice():
	var choice = PrivacyChoice.instance()
	choice.level = level
	choice.parent = self
	display.add_child(choice)

func change_setting():
	var info = PrivacyInfo.instance()
	info.level = level
	info.parent = self
	display.add_child(info)
	
func show_all_settings():
	pass
	
func show_setting():
	var setting = PrivacySetting.instance()
	setting.level = level
	setting.parent = self
	setting.active = true
	display.add_child(setting)
	
func save_setting(active):
	#TODO add armor to player
	opening = false