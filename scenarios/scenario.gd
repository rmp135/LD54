class_name Scenario
extends Resource

@export var name: String
@export var description: String
@export var grid_width = 3
@export var grid_height = 5

@export var prevent_countdown = false

@export var items : Array[ItemDefinition]

func get_item() -> Item:
	var itemdef : ItemDefinition = items.pick_random()
	var item = Item.new(itemdef)
	return item
