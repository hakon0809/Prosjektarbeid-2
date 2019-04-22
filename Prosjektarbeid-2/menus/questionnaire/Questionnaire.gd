extends Node

var org_vp_sz #tracker for original viewport size, might not be needed

var questions = [	{	"type":"line",
						"question":"Do you like this question?"},
					{	"type":"line",
						"question":"Will this show up well?"}]
					

var lineNode = load("res://menus/questionnaire/LineField.tscn")

var voffset = 30 #vertical offset for ass. purposes
var vdist = 15 #vertical distance between questions

var qnodes = [] #Seems procedurally generated nodes aren't so easy to access with get_tree().get_root().find_child stuff
var question_function = {} #Maps question types to their generating functions

func set_question_position(qinstance, num):
	var prev_y = voffset
	if num > 0:
		prev_y = qnodes[num-1].get_bottom()

	qinstance.position.y = prev_y + vdist

func generate_line(question, num):
	var qinstance = lineNode.instance()
	var qdict = {}
	for c in qinstance.get_children():
		qdict[c.get_class()] = c
	
	set_question_position(qinstance, num)
	
	qdict.Label.text = question["question"]
	
	add_child(qinstance)
	qnodes.append(qinstance)
	


func _ready():
	question_function = {
		"line": funcref(self, "generate_line")
	}
	
	org_vp_sz = get_viewport().size
	OS.set_screen_orientation(OS.SCREEN_ORIENTATION_PORTRAIT)
	
	VisualServer.set_default_clear_color("fffdd0")
	
	for i in range(questions.size()):
		question_function[questions[i]["type"]].call_func(questions[i], i)
		
		


func leaving():
	VisualServer.set_default_clear_color("4d4d4d") #Default colour per project settings
	OS.set_screen_orientation(OS.SCREEN_ORIENTATION_LANDSCAPE)