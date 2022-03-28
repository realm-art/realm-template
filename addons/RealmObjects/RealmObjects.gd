tool
extends Control

export(PackedScene) var object_info
var selection : EditorSelection

func add_object(text, description, type):
	var vbox = $VBoxContainer/ScrollContainer/VBoxContainer
	var button = object_info.instance()
	button.set_text(text)
	button.set_description(description)
	button.connect("pressed", self, "on_button_pressed", [type])
	vbox.add_child(button)

func on_button_pressed(type):
	var scene = get_tree().get_edited_scene_root()
	if(scene is RealmScene):
		var node = type.new()
		node.selection = selection
		get_parent_for_type(scene, type).add_child(node)
	else:
		show_warning("Smart Objects can only be added to scenes with a RealmScene root node")

func get_parent_for_type(scene, type):
	match type:
			return scene.lights
		_:
			return scene.misc

func show_warning(text):
	var warning = $VBoxContainer/Warning
	var title = $VBoxContainer/Title
	warning.show()
	title.hide()
	warning.text = text
	$Timer.start()

func _on_timer_timeout():
	var warning = $VBoxContainer/Warning
	var title = $VBoxContainer/Title
	warning.hide()
	title.show()