extends Node

func send_mail(results):
	OS.shell_open("mailto:tsvork@live.no?subject=Results&body="+results)
