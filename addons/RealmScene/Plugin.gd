tool
extends EditorPlugin

const icon = preload("res://addons/RealmScene/icon.svg")
const icon_mesh = preload("res://addons/RealmScene/icon_mesh.svg")
const icon_portals = preload("res://addons/RealmScene/icon_portals.svg")
const icon_lights = preload("res://addons/RealmScene/icon_lights.svg")
const icon_smartobjects = preload("res://addons/RealmScene/icon_smartobjects.svg")
const icon_env = preload("res://addons/RealmScene/icon_env.svg")
const icon_npc = preload("res://addons/RealmScene/icon_npc.svg")
const icon_misc = preload("res://addons/RealmScene/icon_misc.svg")
const icon_spawn = preload("res://addons/RealmScene/icon_spawn.svg")

enum MENU {
	Toggle_DirectionalLight_Shadows_ON,
	Toggle_OmniLight_Shadows_ON,
	Toggle_SpotLight_Shadows_ON,
	Toggle_DirectionalLight_Shadows_OFF,
	Toggle_OmniLight_Shadows_OFF,
	Toggle_SpotLight_Shadows_OFF,
	Toggle_DirectionalLight_ON,
	Toggle_OmniLight_ON,
	Toggle_SpotLight_ON,
	Toggle_DirectionalLight_OFF,
	Toggle_OmniLight_OFF,
	Toggle_SpotLight_OFF,
	Toggle_DirectionalLight_Bakemode_ALL,
	Toggle_DirectionalLight_Bakemode_INDIRECT,
	Toggle_DirectionalLight_Bakemode_DISABLED,
	Toggle_OmniLight_Bakemode_ALL,
	Toggle_OmniLight_Bakemode_INDIRECT,
	Toggle_OmniLight_Bakemode_DISABLED,
	Toggle_SpotLight_Bakemode_ALL,
	Toggle_SpotLight_Bakemode_INDIRECT,
	Toggle_SpotLight_Bakemode_DISABLED,
	Toggle_SS_Reflections_ON,
	Toggle_SS_Reflections_OFF,
	Toggle_SSAO_ON,
	Toggle_SSAO_OFF,
	Toggle_Blur_ON,
	Toggle_Blur_OFF,
	}

var toolbar = null
var _node = null

func _enter_tree() -> void:
	add_custom_type("RealmScene", "Spatial", RealmScene, icon)
	add_custom_type("MeshBatcher", "BakedLightmap", RealmBatcher, icon_mesh)
	add_custom_type("RealmLights", "Spatial", RealmLights, icon_lights)
	add_custom_type("RealmPortals", "Spatial", RealmPortals, icon_portals)
	add_custom_type("RealmSmartObjects", "Spatial", RealmSmartObjects, icon_smartobjects)
	add_custom_type("RealmEnvironment", "WorldEnvironment", RealmEnvironment, icon_env)
	add_custom_type("RealmNPCs", "Spatial", RealmNPCs, icon_npc)
	add_custom_type("RealmMisc", "Spatial", RealmMisc, icon_misc)
	add_custom_type("RealmRespawnPoints", "Spatial", RealmRespawnPoints, icon_spawn)

func build_toolbar(node):
	if(is_instance_valid(toolbar)):
		toolbar.queue_free()	
	var functions = []
	var titles = []
	if(node is RealmScene):
		pass
	elif(node is RealmBatcher):
		pass
	elif(node is RealmLights):
		functions = [
				[
				MENU.Toggle_DirectionalLight_ON,
				MENU.Toggle_DirectionalLight_OFF,
				MENU.Toggle_OmniLight_ON,
				MENU.Toggle_OmniLight_OFF,
				MENU.Toggle_SpotLight_ON,
				MENU.Toggle_SpotLight_OFF,
				],
				[
				MENU.Toggle_DirectionalLight_Bakemode_ALL,
				MENU.Toggle_DirectionalLight_Bakemode_INDIRECT,
				MENU.Toggle_DirectionalLight_Bakemode_DISABLED,
				MENU.Toggle_OmniLight_Bakemode_ALL,
				MENU.Toggle_OmniLight_Bakemode_INDIRECT,
				MENU.Toggle_OmniLight_Bakemode_DISABLED,
				MENU.Toggle_SpotLight_Bakemode_ALL,
				MENU.Toggle_SpotLight_Bakemode_INDIRECT,
				MENU.Toggle_SpotLight_Bakemode_DISABLED,
				],
				[
				MENU.Toggle_DirectionalLight_Shadows_ON, 
				MENU.Toggle_DirectionalLight_Shadows_OFF, 
				MENU.Toggle_OmniLight_Shadows_ON,
				MENU.Toggle_OmniLight_Shadows_OFF,
				MENU.Toggle_SpotLight_Shadows_ON,
				MENU.Toggle_SpotLight_Shadows_OFF
				]
			]
		titles = ["Toggle Lights", "Toggle Bake Modes", "Toggle Shadows"]
	elif(node is RealmPortals):
		pass
	elif(node is RealmSmartObjects):
		pass
	elif(node is RealmEnvironment):
		functions = [
			[
			MENU.Toggle_SS_Reflections_ON,
			MENU.Toggle_SS_Reflections_OFF,
			MENU.Toggle_SSAO_ON,
			MENU.Toggle_SSAO_OFF,
			MENU.Toggle_Blur_ON,
			MENU.Toggle_Blur_OFF
			]
		]
		titles = ["Toggle Effects"]
	elif(node is RealmNPCs):
		pass
	elif(node is RealmMisc):
		pass
	elif(node is RealmRespawnPoints):
		pass
	
	if(functions.size() != 0):
		toolbar = HBoxContainer.new()
		add_control_to_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_MENU, toolbar)
		toolbar.hide()
		
		for i in range(functions.size()):
			var menu := MenuButton.new()
			menu.set_text(titles[i])
			for function in functions[i]:
				menu.get_popup().add_item(MENU.keys()[function].replace("_", " "), function)
			menu.get_popup().connect("id_pressed", self, "_menu_item_pressed")
			toolbar.add_child(menu)

func _exit_tree() -> void:
	toolbar.queue_free()
	remove_custom_type("RealmScene")
	remove_control_from_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_MENU, toolbar)

func handles(object: Object) -> bool:
	if (object is RealmScene ||
		object is RealmLights ||
		object is RealmPortals ||
		object is RealmSmartObjects ||
		object is RealmBatcher ||
		object is RealmEnvironment ||
		object is RealmNPCs ||
		object is RealmMisc ||
		object is RealmRespawnPoints):
		_node = object
		build_toolbar(_node)
		return true
	else:
		return false

func make_visible(visible: bool) -> void:
	if(is_instance_valid(toolbar)):
		toolbar.set_visible(visible)

func _menu_item_pressed(id : int):
	match id:
		MENU.Toggle_DirectionalLight_ON:
			_node.toggle_lights(true, DirectionalLight)
		MENU.Toggle_DirectionalLight_OFF:
			_node.toggle_lights(false, DirectionalLight)
		MENU.Toggle_OmniLight_ON:
			_node.toggle_lights(true, OmniLight)
		MENU.Toggle_OmniLight_OFF:
			_node.toggle_lights(false, OmniLight)
		MENU.Toggle_SpotLight_ON:
			_node.toggle_lights(true, SpotLight)
		MENU.Toggle_SpotLight_OFF:
			_node.toggle_lights(false, SpotLight)
			
		MENU.Toggle_DirectionalLight_Bakemode_ALL:
			_node.toggle_bake_mode(DirectionalLight.BAKE_ALL, DirectionalLight)
		MENU.Toggle_DirectionalLight_Bakemode_INDIRECT:
			_node.toggle_bake_mode(DirectionalLight.BAKE_INDIRECT, DirectionalLight)
		MENU.Toggle_DirectionalLight_Bakemode_DISABLED:
			_node.toggle_bake_mode(DirectionalLight.BAKE_DISABLED, DirectionalLight)
		MENU.Toggle_OmniLight_Bakemode_ALL:
			_node.toggle_bake_mode(OmniLight.BAKE_ALL, OmniLight)
		MENU.Toggle_OmniLight_Bakemode_INDIRECT:
			_node.toggle_bake_mode(OmniLight.BAKE_INDIRECT, OmniLight)
		MENU.Toggle_OmniLight_Bakemode_DISABLED:
			_node.toggle_bake_mode(OmniLight.BAKE_DISABLED, OmniLight)
		MENU.Toggle_SpotLight_Bakemode_ALL:
			_node.toggle_bake_mode(SpotLight.BAKE_ALL, SpotLight)
		MENU.Toggle_SpotLight_Bakemode_INDIRECT:
			_node.toggle_bake_mode(SpotLight.BAKE_INDIRECT, SpotLight)
		MENU.Toggle_SpotLight_Bakemode_DISABLED:
			_node.toggle_bake_mode(SpotLight.BAKE_DISABLED, SpotLight)
		
		MENU.Toggle_DirectionalLight_Shadows_ON:
			_node.toggle_shadows(true, DirectionalLight)
		MENU.Toggle_DirectionalLight_Shadows_OFF:
			_node.toggle_shadows(false, DirectionalLight)
		MENU.Toggle_OmniLight_Shadows_ON:
			_node.toggle_shadows(true, OmniLight)
		MENU.Toggle_OmniLight_Shadows_OFF:
			_node.toggle_shadows(false, OmniLight)
		MENU.Toggle_SpotLight_Shadows_ON:
			_node.toggle_shadows(true, SpotLight)
		MENU.Toggle_SpotLight_Shadows_OFF:
			_node.toggle_shadows(false, SpotLight)
		
		MENU.Toggle_SS_Reflections_ON:
			_node.toggle_ss_reflections(true)
		MENU.Toggle_SS_Reflections_OFF:
			_node.toggle_ss_reflections(false)
		MENU.Toggle_SSAO_ON:
			_node.toggle_ssao(true)
		MENU.Toggle_SSAO_OFF:
			_node.toggle_ssao(false)
		MENU.Toggle_Blur_ON:
			_node.toggle_blur(true)
		MENU.Toggle_Blur_OFF:
			_node.toggle_blur(false)
	
	get_editor_interface().get_inspector().refresh()
