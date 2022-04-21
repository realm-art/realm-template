#Smart Object script - Do not modify
tool
extends SmartObject
class_name FloodLight

#Smart Object Scene Instancing
const scene = "res://smart_objects/floodlight/Floodlight.tscn"

#Smart Object properties - Set via inspector
export(bool) var auto_turn_on = true
export(float) var light_energy = 1 
export(float) var light_range = 10 
export(float) var light_angle = 50 
export(Color) var light_color = Color.yellow
