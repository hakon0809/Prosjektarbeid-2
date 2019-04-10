extends Node

var org_vp_sz

func _ready():
	org_vp_sz = get_viewport().size
	print(org_vp_sz)
	print(funcref(OS, "set_screen_orientation"))
	#print(OS.set_screen_orientation)
	print("Orientation: " + str(OS.screen_orientation))
	OS.set_screen_orientation(OS.SCREEN_ORIENTATION_PORTRAIT)
	print("Orientation: " + str(OS.screen_orientation))
	print(get_viewport().size)
#	get_viewport().set_size_override(org_vp_sz.y, org_vp_sz.x)
	#get_viewport().set_size_override(true, Vector2(org_vp_sz.y, org_vp_sz.x), Vector2( 0, 0 ))
	#print(get_viewport().size)


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
