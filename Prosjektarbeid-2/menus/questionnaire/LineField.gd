extends VBoxContainer

func get_answer():
	var question = self.find_node("Label").text
	var answer = self.find_node("LineEdit").text
	if not answer:
		return null
	return [question, answer]