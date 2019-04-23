extends VBoxContainer

func init(question):
	find_node("Label").text = question["question"]

func get_answer():
	return true