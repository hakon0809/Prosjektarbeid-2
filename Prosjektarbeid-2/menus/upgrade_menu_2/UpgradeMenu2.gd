extends Container

onready var scene = $MarginContainer/PanelContainer/VBoxContainer/SceneContainer

func _ready():
	var scene_1 = load("res://menus/upgrade_menu_2/Scene1.tscn").instance()
	scene.add_child(scene_1)