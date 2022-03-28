#Base node type for smart objects
tool
extends Spatial
class_name SmartObject

#Smart Object Scene Instancing
var selection
func _enter_tree():
	SceneInstantiator.instance_scene(self, get("scene"), selection)
