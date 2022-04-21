#Smart Object script - Do not modify
tool
extends SmartObject
class_name LightBulb

#Smart Object Scene Instancing
const scene = "res://smart_objects/light_bulb/LightBulb.tscn"

#Smart Object properties - Set via inspector
export(bool) var auto_turn_on = true
export(float) var light_energy = 1 
export(float) var light_range = 12 
export(Color) var light_color = Color.yellow 
