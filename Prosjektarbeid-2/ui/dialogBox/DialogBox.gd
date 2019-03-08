extends RichTextLabel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
#const DIALOG_CLASS = preload("res://ui/dialogBox/RichTextLabel.gd")

var dialog = ["Vil dette spillet bli helt awesome med disse dialogboksene?", 
"Lorem ipsum lusum Lorem ipsum lusum Lorem ipsum lusum?", 
"Lalalal Bababba Lalalal Bababba Lalalal Bababba Lalalal?"]
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

#func _on_Button_pressed():
	#her kommer funksjonalitetet knyttet til brukervalg og dialogene
	#registeres i f.eks et array de ulike valgene som er indeksert
#	pass # replace with function body


#func _on_Button2_pressed():
	#her kommer funksjonalitetet knyttet til brukervalg og dialogene
	#registeres i f.eks et array de ulike valgene som er indeksert
#	pass # replace with function body


func _on_ButtonYes_pressed():
	print("knapp1")


func _on_ButtonNo_pressed():
	print("knapp2")


func _on_ButtonYes_button_up():
	print("button_up")
