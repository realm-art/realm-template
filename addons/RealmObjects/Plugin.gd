tool
extends EditorPlugin

const scene_path = "res://addons/RealmObjects/RealmObjects.tscn"
const icon = preload("res://addons/RealmScene/icon_smartobjects.svg")

var dock
var selection

func _enter_tree() -> void:
	#Init dock
	dock = load(scene_path).instance()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, dock)
	populate_dock()
	#Init EditorSelection
	selection = get_editor_interface().get_selection()
	dock.selection = selection

func _exit_tree():
	remove_control_from_docks(dock)
	dock.free()

func populate_dock():
	pass
