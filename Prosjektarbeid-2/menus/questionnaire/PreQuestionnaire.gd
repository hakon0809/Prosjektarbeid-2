#extends Questionnaire
extends "res://menus/questionnaire/Questionnaire.gd"

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

func write_to_Globals(answers):
	Globals.pre_questionnaire = answers

func goto_next():
	get_tree().change_scene('res://levels/BART/BARTIntro.tscn')


func _ready():
	.init(questions)