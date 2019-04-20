extends Node

var org_vp_sz

var questions = [{	"type":"line",
					"question":"Do you like this question?"}]
					
var lineNode = load("res://menus/questionnaire/LineField.tscn")

func generate_line(question, num):
	print("generating a line")
	var qinstance = lineNode.instance()
	qinstance.set_name(str(num))
	add_child(qinstance)
	
	
var question_function = {
	"line": funcref(self, "generate_line")
	}





func _ready():
	org_vp_sz = get_viewport().size
	OS.set_screen_orientation(OS.SCREEN_ORIENTATION_PORTRAIT)
	VisualServer.set_default_clear_color("fffdd0")
	for i in range(questions.size()):
		question_function[questions[i]["type"]].call_func(questions[i], i)
		
		



func leaving():
	VisualServer.set_default_clear_color("4d4d4d") #Default colour per project settings