class_name Inventory
extends TextureRect

@export var width := 10
@export var height := 10

@export var items : Array[Item] = []

signal item_added(inventory: Inventory, item: InventoryItem)

# Called when the node enters the scene tree for the first time.
func _ready():
	var icon = preload("res://inventory_item.tscn")
	size.x = width * 32
	size.y = height * 32
	
	for item in items:
		var n = icon.instantiate()
		n.item = item
		n.dropped.connect(get_parent().on_item_dropped)
		
		add_child(n)

func add_item(icon: InventoryItem):
	var x = floor((icon.global_position.x - global_position.x) / 32.0)
	var y = floor((icon.global_position.y - global_position.y) / 32.0)
	icon.item.x = x
	icon.item.y = y
	icon.position = Vector2(x * 32, y * 32)
	icon.get_parent().remove_child(icon)
	add_child(icon)
		
func can_drop(icon: InventoryItem) -> bool:
	var x = floor((icon.global_position.x - global_position.x) / 32.0)
	var y = floor((icon.global_position.y - global_position.y) / 32.0)
	if x < 0 or y < 0:
		return false
	if x + icon.item.width > width or y + icon.item.height > height:
		return false
	return true
	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
