tool
extends EditorPlugin

const scene_path = "res://addons/RealmTutorial/RealmTutorial.tscn"

var selection

func _enter_tree() -> void:
	Tutorial.dock = load(scene_path).instance()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, Tutorial.dock)
	
	selection = get_editor_interface().get_selection()
	selection.connect("selection_changed", self, "_on_selection_changed")

func _exit_tree():
	remove_control_from_docks(Tutorial.dock)
	Tutorial.dock.free()

func _on_selection_changed():
	var selected_nodes = selection.get_selected_nodes() 
	if(selected_nodes.size() != 0):
		var node = selected_nodes[0]
		Tutorial.set_active_object(node)
