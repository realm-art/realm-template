#Smart Object script - Do not modify
tool
extends SmartObject
class_name Candle

#Smart Object Scene Instancing
const scene = "res://smart_objects/candle/Candle.tscn"

#Smart Object properties - Set via inspector
export(Vector2) var flickering_light_energy_range = Vector2(0.5, 2)
export(float) var flickering_speed = 50
export(bool) var flickering = true 
export(float) var light_energy = 1 
export(float) var light_range = 4 
export(Color) var light_color = Color.yellow 

