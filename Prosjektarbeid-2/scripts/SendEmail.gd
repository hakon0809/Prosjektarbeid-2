extends Node

func send_mail(results):
	var mailstring = "mailto:daretoshare.results@gmail.com?subject=Results&body="
	var globals = get_tree().get_root().globals
	var activities = globals.get_all_activities()
	for activity in activities:
		for level in activity:
			mailstring += format_data(level)+"%0A"
	var data = globals
	OS.shell_open(mailstring)
	
func format_data(level):
	var datastring = ""
	for data in level:
		datastring += data+" "
	return datastring