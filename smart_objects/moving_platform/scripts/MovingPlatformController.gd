#Smart Object script - Do not modify
tool
extends SmartObject
class_name MovingPlatform

#Smart Object Scene Instancing
const scene = "res://smart_objects/moving_platform/MovingPlatform.tscn"

#Smart Object properties - Set via inspector
const MOVE_TYPE = {
	ONCE = 0,
	LOOP = 1, 
	BACK_AND_FORTH = 2,
}

const INTERACTION_TYPE = {
	PAUSE = 0,
	REVERSE = 1
}

const ROTATION_MODE = {
	NONE = 0,
	Y = 1,
	XY = 2,
	XYZ = 3,
	ORIENTED = 4
}

export(Animation) var movement_animation = null 
export(float) var movement_animation_speed = 1.0
export(String, FILE, "*.tscn") var platform_body = "res://assets/platforms/PlatformBody.tscn" setget set_platform_body
export(float, 0.0, 1.0) var platform_offset = 0.0 setget set_platform_offset
export(float, 0.0, 60.0) var idle_time = 1.0
export(MOVE_TYPE) var move_type = MOVE_TYPE.BACK_AND_FORTH
export(INTERACTION_TYPE) var interaction = INTERACTION_TYPE.PAUSE
export(ROTATION_MODE) var rotation_mode = ROTATION_MODE.Y setget set_rotation_mode
export(bool) var auto_move = true
export(float, 50.0, 2000.0) var max_update_distance = 100

#Smart Object logic
var platform_body_instance
var is_linear = false
var is_paused = auto_move

func _ready():
	update_platform_body()
	update_platform_offset()
	update_rotation_mode()

func set_platform_body(value):
	platform_body = value
	update_platform_body()

func update_platform_body():
	if is_valid_instance():
		for child in $path_follow.get_children():
			child.queue_free()
		if !platform_body.empty():
			var body_scene = ResourceLoader.load(platform_body)
			platform_body_instance = body_scene.instance()
			$path_follow.add_child(platform_body_instance)

func set_platform_offset(value):
	platform_offset = value
	update_platform_offset()

func update_platform_offset():
	if is_valid_instance():
		$path_follow.unit_offset = platform_offset

func set_rotation_mode(value: int):
	rotation_mode = value
	update_rotation_mode()

func update_rotation_mode():
	if is_valid_instance():
		$path_follow.rotation_mode = rotation_mode

func is_valid_instance():
	return is_inside_tree() and get_node_or_null("path_follow")
