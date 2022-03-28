#Smart Object script - Do not modify
tool
extends SmartObject
class_name LootSpawnArea

#Smart Object Scene Instancing
const scene = "res://smart_objects/loot_spawn/LootSpawnArea.tscn"

#Smart Object properties - Set via inspector
export(int, FLAGS, "Common", "Uncommon", "Rare", "Legendary", "Mythic", "Genesis") var rarities = 15 
