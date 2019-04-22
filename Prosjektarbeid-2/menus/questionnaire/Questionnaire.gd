extends VBoxContainer

var org_vp_sz #tracker for original viewport size, might not be needed

var questions = [	{	"type":"line",
						"question":"Do you like this question?"},
					{	"type":"line",
						"question":"Will this show up well?"}]
					
var rel = "res://menus/questionnaire/"
var line_node = load("res://menus/questionnaire/LineField.tscn")
var submit_button = load(rel + "SubmitButton.tscn")

var voffset = 30 #vertical offset for ass. purposes

var qnodes = [] #Seems procedurally generated nodes aren't so easy to access with get_tree().get_root().find_child stuff
var question_function = {} #Maps question types to their generating functions

func generate_line(question, num):
	var qinstance = line_node.instance()
	var qdict = {}
	for c in qinstance.get_children():
		qdict[c.get_class()] = c
	
	
	qdict.Label.text = question["question"]
	
	add_child(qinstance)
	qnodes.append(qinstance)
	
func generate_submit():
	var sbinstance = submit_button.instance()
	add_child(sbinstance)
	sbinstance.connect("pressed", self, "_on_SubmitButton_pressed")

func _ready():
	question_function = {
		"line": funcref(self, "generate_line")
	}
	
	org_vp_sz = get_viewport().size
	OS.set_screen_orientation(OS.SCREEN_ORIENTATION_PORTRAIT)
	
	VisualServer.set_default_clear_color("fffdd0")
	
	for i in range(questions.size()):
		question_function[questions[i]["type"]].call_func(questions[i], i)
	generate_submit()
		

func _on_SubmitButton_pressed():
	print("Yeehaw my yoodle.")

func leaving():
	VisualServer.set_default_clear_color("4d4d4d") #Default colour per project settings
	OS.set_screen_orientation(OS.SCREEN_ORIENTATION_LANDSCAPE)