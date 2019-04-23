extends Questionnaire

var questions = [
{	"type": LINE,
	"question": "Is this the post-questionnaire?"},
{	"type": RADIO,
	"question": "How post is this questionnaire?",
	"radios": 10}
]

func write_to_Globals(answers):
	Globals.post_questionnaire = answers

func goto_next():
	Globals.send_email()
	get_tree().change_scene("res://menus/TitleScreen.tscn")

func _ready():
	.init(questions)