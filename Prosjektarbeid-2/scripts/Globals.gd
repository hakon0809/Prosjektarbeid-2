extends Node

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

func set_upgrade(upgrade, value):
	upgrades[upgrade] = value
	
func get_upgrade(upgrade):
	return upgrades[upgrade]
	
func get_all_upgrades():
	return upgrades
	
func set_activity(activity, level, string):
	activities[activity][level-1].append(string)
	
func get_all_activities():
	return activities
	
