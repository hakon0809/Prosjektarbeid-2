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
	get_tree().change_scene("res://menus/Resendemail.tscn")

func _ready():
	.init(questions)
