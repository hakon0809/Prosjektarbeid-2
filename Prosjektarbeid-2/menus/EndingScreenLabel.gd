extends Label

func _ready():
	text = "You chose to share " + str(Globals.get_shared_options()) + "/" + str(Globals.get_total_sharing_options()) + """ options.
	Of these, """ + str(Globals.get_activated_upgrades()) + """ were necessary
	for the upgrades you wanted."""
