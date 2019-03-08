extends MarginContainer

onready var PrivacyChoice = preload("res://menus/choices/PrivacyChoice.tscn")
onready var PrivacyInfo = preload("res://menus/choices/PrivacyInfo.tscn")
onready var PrivacySetting = preload("res://menus/choices/PrivacySettings.tscn")
onready var EndLevelSettings = preload("res://menus/choices/EndLevelSettings.tscn")
var level
var active_options = [false, false, false]
var scale = Vector2(0, 0)
var opening = true
var end_level
var parent

func _ready():
	self.rect_scale = Vector2(0, 0)
	
func _process(delta):
	if opening:
		if scale.x < 1:
			scale.x += 0.05
			scale.y += 0.05
			self.rect_scale = scale
	else:
		if scale.x > 0:
			scale.x -= 0.05
			scale.y -= 0.05
			self.rect_scale = scale
		else:
			self.queue_free()
			
		
		
func choice(parent):
	self.parent = parent
	var choice = PrivacyChoice.instance()
	choice.level = level
	choice.parent = self
	add_child(choice)
	
func settings_menu(active):
	active_options = active
	var settings = EndLevelSettings.instance()
	settings.level = level
	settings.parent = self
	settings.active = active_options
	add_chld(settings)

func change_setting():
	var info = PrivacyInfo.instance()
	info.level = level
	info.parent = self
	add_child(info)
		
func show_setting(active, level):
	var setting = PrivacySetting.instance()
	setting.level = level
	setting.parent = self
	setting.active = active
	add_child(setting)
	
func save_setting(option, active):
	if active:
		active_options[option-1] = true
	else:
		active_options[option-1] = false
	if end_level:
		settings_menu(active_options)
	else:
		parent.save_choice(active)
		opening = false