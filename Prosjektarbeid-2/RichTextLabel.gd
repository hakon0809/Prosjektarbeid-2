extends RichTextLabel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var dialog = ["Dette spillet blir awesome med disse dialogboksene", 
"Lorem ipsum lusum Lorem ipsum lusum Lorem ipsum lusum", 
"Lalalal Bababba Lalalal Bababba Lalalal Bababba Lalalal"]
var page = 0

func _ready():
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)
	
func _input(event):
	if (event.is_pressed() and event.button_index == BUTTON_LEFT):
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size()-1:
				page += 1
				set_bbcode(dialog[page])
				set_visible_characters(0)
		else:
			set_visible_characters(get_total_character_count())
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)