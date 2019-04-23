extends VBoxContainer

enum {LINE, RADIO, SUBMIT}

var questions = [	
{	"type": LINE,
	"question": "Do you like this question?"},
{	"type": LINE,
	"question": "Will this show up well?"},
{	"type": RADIO,
	"question": "An example radio from integer.",
	"radios": 7},
{	"type": RADIO,
	"question": "An example radio from a list.",
	"radios": ["Donkey Kong", "Monkey Mong", "Bonkey Long", "Cronkey Gong"]}
]

var qnodes = [] #For easy enumerated access to question nodes

func gen_path(s):
	var rel = "res://menus/questionnaire/"
	return load(rel + s + ".tscn")
var question_path = {
	LINE: 	gen_path("LineField"),
	RADIO:	gen_path("RadioField"),
	SUBMIT:	gen_path("SubmitButton")
}

func generate_question(question):
	var qinstance = question_path[question["type"]].instance()
	add_child(qinstance)
	qnodes.append(qinstance)
	qinstance.init(question)

func generate_submit():
	var sbinstance = question_path[SUBMIT].instance()
	add_child(sbinstance)
	sbinstance.connect("pressed", self, "_on_SubmitButton_pressed")

func invalid_answer(qnode):
	"Extend to handle stuff like marking an unanswered question, showing a pop-up, wutevs."
	print(qnode)
	return null

func _ready():
	OS.set_screen_orientation(OS.SCREEN_ORIENTATION_PORTRAIT)
	
	VisualServer.set_default_clear_color("fffdd0")

	for question in questions:
		generate_question(question)
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