extends VBoxContainer

##var org_vp_sz #tracker for original viewport size, might not be needed after all

enum {LINE}

var questions = [	{	"type":LINE,
						"question":"Do you like this question?"},
					{	"type":LINE,
						"question":"Will this show up well?"}]

var rel = "res://menus/questionnaire/"
var line_node = load(rel + "LineField.tscn")
var submit_button = load(rel + "SubmitButton.tscn")

##var voffset = 30 #vertical offset for ass. purposes

var qnodes = [] #Seems procedurally generated nodes aren't so easy to access with get_tree().get_root().find_child stuff? Besides, heavy op.
var question_function = {} #Maps question types to their generating functions

func add_question(qinstance):
	add_child(qinstance)
	qnodes.append(qinstance)

func generate_line(question, num):
	var qinstance = line_node.instance()
	var qdict = {}
	for c in qinstance.get_children():
		qdict[c.get_class()] = c
	
	
	qdict.Label.text = question["question"]
	
	add_question(qinstance)

func generate_submit():
	var sbinstance = submit_button.instance()
	add_child(sbinstance)
	sbinstance.connect("pressed", self, "_on_SubmitButton_pressed")

func invalid_answer(qnode):
	"Extend to handle stuff like marking an unanswered question, showing a pop-up, wutevs."
	return null

func _ready():
	question_function = {
		LINE: funcref(self, "generate_line")
	}
	
	##org_vp_sz = get_viewport().size
	OS.set_screen_orientation(OS.SCREEN_ORIENTATION_PORTRAIT)
	
	VisualServer.set_default_clear_color("fffdd0")
	
	for i in range(questions.size()):
		question_function[questions[i]["type"]].call_func(questions[i], i)
	generate_submit()
		
func _on_SubmitButton_pressed():
	var answers = []
	print("Yeehaw my yoodle.")
	for q in qnodes: #build the answers list or exit if invalid answer
		var answer = q.get_answer()
		answers.append(answer)
		if answer == null:
			return invalid_answer(q)
	finish_questionnaire(answers)

func finish_questionnaire(answers):
	#TODO: Save answers in data gathering system
	print(answers)
	VisualServer.set_default_clear_color("4d4d4d") #Default colour per project settings
	OS.set_screen_orientation(OS.SCREEN_ORIENTATION_LANDSCAPE)