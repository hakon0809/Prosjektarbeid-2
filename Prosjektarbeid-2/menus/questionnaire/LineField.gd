extends VBoxContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_answer():
	var question = self.find_node("Label").text
	var answer = self.find_node("LineEdit").text
	if not answer:
		return null
	return [question, answer]