extends Resource

class_name Item

@export var name: String = "test"
@export var texture: Texture2D 
@export var width: int = 1
@export var height: int = 1
@export var value: int = 0
@export var is_quest = false

@export var x: int = 0
@export var y: int = 0

func _init(definition: ItemDefinition):
	name = definition.name
	texture = definition.texture
	width = definition.width
	height = definition.height
	value = randi_range(definition.val_from, definition.val_to)
	is_quest = definition.is_quest
