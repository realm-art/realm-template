tool
extends Control

func set_active_object(node):
	if(node is SmartObject):
		if(node is RealmPortal):
			set_tutorial(Tutorial.TUTORIALS["RealmPortal"])
	else:
		name = "Tutorial"

func set_tutorial(tutorial):
	#TODO: Display tutorial data
	pass

func _on_meta_clicked(meta):
	OS.shell_open(meta)
