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

var upgrade_1 = false
var upgrade_2 = false
var upgrade_3 = false
var secret_upgrade = false
var upgrades = [secret_upgrade, upgrade_1, upgrade_2, upgrade_3]

var upgrade_activity_1 = []
var upgrade_activity_2 = []
var upgrade_activity_3 = []
var upgrade_activities = [upgrade_activity_1,  upgrade_activity_2, upgrade_activity_3]
var settings_activity_1 = []
var settings_activity_2 = []
var settings_activity_3 = []
var settings_activities = [settings_activity_1, settings_activity_2, settings_activity_3]
var activities = [upgrade_activities, settings_activities]

func play_song(song, volume = 0):
	# Updates the song and volume, and if not muted starts the song
	music_player.stream = song
	music_player.volume_db = volume
	if !muted[0]:
		music_player.play()

func set_upgrade(upgrade, value):
	upgrades[upgrade] = value
	get_tree().get_root().get_node("Node/Player/KinematicBody2D").upgrade_changed(upgrade)
	
func get_upgrade(upgrade):
	return upgrades[upgrade]
	
func get_all_upgrades():
	return upgrades
	
func set_activity(activity, level, string):
	activities[activity][level].append(string)
	
func send_email():
	var mailstring = "mailto:daretoshare.results@gmail.com?subject=Results&body="
	for activity in activities:
		for level in activity:
			mailstring += format_data(level)+"%0A"
	OS.shell_open(mailstring)
	
func format_data(level):
	var datastring = "| "
	for data in level:
		datastring += data+" | "
	return datastring
