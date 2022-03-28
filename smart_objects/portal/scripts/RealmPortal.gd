#Smart Object script - Do not modify
tool
extends SmartObject
class_name RealmPortal

#Smart Object Scene Instancing
const scene = "res://smart_objects/portal/RealmPortal.tscn"

#Smart Object properties - Set via inspector
export(String) var target_realm setget set_target_realm
export(int) var target_portal
export(Vector3) var spawn_point_offset = Vector3(3,0.2,4.0) setget set_spawn_point

export(String, FILE, "*.tscn,*.scn") var portal_mesh_path setget load_portal_mesh
export(int, 0, 20) var portal_variation = 0 setget set_portal_variation
export(Resource) var inactive_material
export(Resource) var active_material

#Smart Object logic
var portal_mesh

func set_target_realm(new_target_scene : String):
	target_realm = new_target_scene
	var active = target_realm && !target_realm.empty()
	update_portal_plane(active)

func set_portal_variation(index):
	portal_variation = index
	update_portal_variation(index)

func set_spawn_point(new_spawn_point : Vector3):
	$SpawnPoint.translation = new_spawn_point
	spawn_point_offset = new_spawn_point

func _ready():
	load_portal_mesh(portal_mesh_path)
	set_target_realm(target_realm)
	set_portal_variation(portal_variation)

func load_portal_mesh(path):
	portal_mesh_path = path
	if(portal_mesh_path):
		var new_mesh = ResourceLoader.load(portal_mesh_path).instance()
		if(get_node_or_null("PortalMesh")):
			remove_child($PortalMesh)
		new_mesh.name = "PortalMesh"
		portal_mesh = new_mesh
		add_child(new_mesh)
		set_portal_variation(portal_variation)

func update_portal_plane(visible):
	if(portal_mesh && portal_mesh.get("portal_screen_mesh")):
		var portal_plane = portal_mesh.get_node(portal_mesh.portal_screen_mesh)
		var mat_prop = "material/%s" % portal_mesh.portal_screen_material_index
		portal_plane.set(mat_prop, active_material if visible else inactive_material)

func update_portal_variation(index):
	if(portal_mesh && portal_mesh.get("materials")):
		var materials = portal_mesh.get("materials")
		if(materials.size() > index):
			var mesh_instance = portal_mesh.get_child(0)
			if(mesh_instance is MeshInstance):
				mesh_instance.set("material/0", materials[index])

