#Root node of all Realms
tool
extends Spatial
class_name RealmScene

export(String) var realm_name = "My Realm"
export(String) var realm_description = "This is a Realm."
export(Image) var realm_thumbnail
export(float) var water_height = -20.0
export(float) var respawn_height = -10.0
export(Array, String, FILE, "*.ogg,*.wav") var background_music = []
export(Array, String, FILE, "*.ogg,*.wav") var background_ambient = []

var static_meshes : RealmBatcher
var lights : RealmLights
var portals : RealmPortals
var smart_objects : RealmSmartObjects
var world_env : RealmEnvironment
var npcs : RealmNPCs
var misc : RealmMisc
var respawn_points : RealmRespawnPoints

func _enter_tree():
	init_containers()

func init_containers():
	world_env = init_container("WorldEnvironment", RealmEnvironment)
	static_meshes = init_container("StaticMeshes", RealmBatcher)
	lights = init_container("Lights", RealmLights)
	portals = init_container("Portals", RealmPortals)
	smart_objects = init_container("SmartObjects", RealmSmartObjects)
	npcs = init_container("NPCs", RealmNPCs)
	misc = init_container("Misc", RealmMisc)
	respawn_points = init_container("RespawnPoints", RealmRespawnPoints)

func init_container(_name, type):
	var node = get_node_or_null(_name)
	if(!node):
		node = type.new()
		node.name = _name
		add_child(node)
		if Engine.editor_hint:
			node.set_owner(get_tree().get_edited_scene_root())
	return node

