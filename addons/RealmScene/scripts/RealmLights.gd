tool
extends Spatial
class_name RealmLights

var lights
var root = self

func toggle_shadows(enabled, type, search_root = self):
	for light in get_lights(search_root):
		if(light is type):
			light.shadow_enabled = enabled

func toggle_lights(enabled, type, search_root = self):
	for light in get_lights(search_root):
		if(light is type):
			if(!Engine.editor_hint && !enabled):
				light.queue_free()
			else:
				light.editor_only = !enabled

func toggle_bake_mode(mode, type, search_root = self):
	for light in get_lights(search_root):
		if(light is type):
			light.light_bake_mode = mode

func get_lights(search_root = self):
	if(!lights || Engine.editor_hint || search_root != root):
		root = search_root
		lights = []
		get_light_children(root)
	return lights

func get_light_children(node):
	if(node is DirectionalLight || node is OmniLight || node is SpotLight):
		lights.append(node)
	for child in node.get_children():
		get_light_children(child)
