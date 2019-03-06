extends Node

func send_mail_like_an_amateur(results):
	OS.shell_open("mailto:tsvork@live.no?subject=Results&body="+results)
