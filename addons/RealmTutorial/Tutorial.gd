tool
extends Node

const TUTORIALS = {
	"RealmPortal": {
		"name": "Realm Portal",
		"properties": {
				"Target Realm": "Defines the Realm this portal leads to."
		}
	}
	#TODO: Add tutorials
}

var dock

func set_active_object(node):
	dock.set_active_object(node)
