#Smart Object script - Do not modify
tool
extends SmartObject
class_name Button3D

#Smart Object Scene Instancing
const scene = "res://smart_objects/3d_button/3DButton.tscn"

#Smart Object properties - Set via inspector
export(Color) var base_color = Color.gray
export(Color) var selected_color = Color.red
export(Array, NodePath) var object_refs = []
