extends Node

func send_mail(results):
	#TODO fix format
	OS.shell_open("mailto:insert@email.here?subject=Results&body="+results)
