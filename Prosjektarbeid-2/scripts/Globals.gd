extends Node

var main_menu_song = load("res://levels/common/assets/sounds/Fantastic A.ogg")
var city_song =  load("res://levels/common/assets/sounds/The Walrus and the Carpenter.ogg")
var music_player = AudioStreamPlayer.new()
var muted = [false, false]
# A reference to the music/sound buttons are needed to remember their state
# across scene changes.
var music_button
var sound_button

func _ready():
	self.add_child(music_player)

var upgrades = {1: [false, false, false],
		2: [false, false, false],
		3: [false, false, false]}
		
var health_penalty = 0

var upgrade_activity = ["", "", ""]

var bart_score
var bart_aggregate

func play_song(song, volume = 0):
	# Updates the song and volume, and if not muted starts the song
	music_player.stream = song
	music_player.volume_db = volume
	if !muted[0]:
		music_player.play()

func set_upgrade(upgrade, value):
	for i in value.size():
		upgrades[upgrade][i] = value[i]
	get_tree().get_root().get_node("Skull_level_" + str(upgrade) + "/Player/KinematicBody2D").upgrade_changed(upgrade)

func get_upgrade(upgrade):
	return upgrades[upgrade]
	
func get_all_upgrades():
	return upgrades
	
func set_activity(activity, string):
	upgrade_activity[activity] = string
	
func set_bart_score(score, aggregate):
	bart_score = score
	bart_aggregate = aggregate
	
func send_email():
	var mailstring = "mailto:daretoshare.results@gmail.com?subject=Results&body="
#	for activity in activities:
#		for level in activity:
#			mailstring += format_data(level)+"%0A"
#	OS.shell_open(mailstring)
	
func format_data(level):
	var datastring = "| "
	for data in level:
		datastring += data+" | "
	return datastring
