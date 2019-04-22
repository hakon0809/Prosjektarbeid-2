extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_bottom():
	var bottom = self.get_children().back()
	return bottom.rect_position.y + bottom.rect_size.y + self.position.y