class_name SceneInstantiator

#Replace registered node types with scene instances
static func instance_scene(node, path, selection):
	if(node.get_child_count() != 0):
		return
	var scene = load(path)
	if(scene):
		node.name = "TEMP"
		var instance = scene.instance()
		var parent = node.get_parent()
		parent.add_child(instance)
		instance.set_owner(parent.get_tree().get_edited_scene_root())
		node.queue_free()
		selection.clear()
		selection.add_node(instance)
