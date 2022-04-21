tool
extends EditorPlugin

const scene_path = "res://addons/RealmObjects/RealmObjects.tscn"
const icon = preload("res://addons/RealmScene/icon_smartobjects.svg")

var dock
var selection

func _enter_tree() -> void:
	add_custom_type("RealmPortal", "Spatial", RealmPortal, icon)
	add_custom_type("LootSpawnArea", "Spatial", LootSpawnArea, icon)
	add_custom_type("MovingPlatform", "Spatial", MovingPlatform, icon)
	add_custom_type("3DButton", "Spatial", Button3D, icon)
	add_custom_type("Door", "Spatial", Door, icon)
	add_custom_type("Candle", "Spatial", Candle, icon)
	add_custom_type("FloodLight", "Spatial", FloodLight, icon)
	#Init dock
	dock = load(scene_path).instance()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, dock)
	populate_dock()
	#Init EditorSelection
	selection = get_editor_interface().get_selection()
	dock.selection = selection

func _exit_tree():
	remove_custom_type("RealmPortal")
	remove_custom_type("LootSpawnArea")
	remove_custom_type("MovingPlatform")
	remove_custom_type("3DButton")
	remove_custom_type("Door")
	remove_custom_type("Candle")
	remove_custom_type("FloodLight")
	remove_control_from_docks(dock)
	dock.free()

func populate_dock():
	dock.add_object(
		"Realm Portal", 
		"A portal that can be linked to any other Realm",
		RealmPortal
		)
	dock.add_object(
		"Loot Spawn Area", 
		"An area in which items are allowed to spawn",
		LootSpawnArea
		)
	dock.add_object(
		"Moving Platform", 
		"A platform that follows a path and can be interacted with using 3D buttons",
		MovingPlatform
		)
	dock.add_object(
		"3D Button", 
		"A button that can be connected to other smart objects",
		Button3D
		)
	dock.add_object(
		"Door", 
		"A door. Can be interacted with using 3D buttons",
		Door
		)
	dock.add_object(
		"Candle", 
		"A flickerling candle",
		Candle
		)
	dock.add_object(
		"Floodlight", 
		"A floodlight. Can be turned on and off using 3D buttons.",
		FloodLight
		)
	pass
