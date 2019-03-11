extends Node

func send_mail(results):
	#TODO fix format -> 1st/2nd/3rd choice, changing settings, ballon game
	OS.shell_open("mailto:daretoshare.results@gmail.com?subject=Results&body="+results)
