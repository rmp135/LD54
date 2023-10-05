class_name Inventory
extends TextureRect

@export var width := 10
@export var height := 10

@export var hover_controller : HoverController

@export var items : Array[Item] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var inventory_item = preload("res://inventory_item.tscn")
	resize()
	
	for item in items:
		var n = inventory_item.instantiate()
		n.item = item
		n.hover_controller = hover_controller
		n.dropped.connect(get_parent().on_item_dropped)
		n.on_hover.connect(hover_controller.on_hovered)
		n.on_unhover.connect(hover_controller.on_unhovered)
		
		add_child(n)
		
func clear_items():
	for c in get_children():
		remove_child(c)

func resize():
	size.x = width * 32
	size.y = height * 32

func add_item(inventory_item: InventoryItem):
	var x = floor((inventory_item.global_position.x - global_position.x) / 32.0)
	var y = floor((inventory_item.global_position.y - global_position.y) / 32.0)
	add_item_at(inventory_item, x, y)

func add_item_at(inventory_item: InventoryItem, x: int, y: int):
	inventory_item.item.x = x
	inventory_item.item.y = y
	inventory_item.position = Vector2(x * 32, y * 32)
	if inventory_item.get_parent() != null:
		inventory_item.get_parent().remove_child(inventory_item)
	add_child(inventory_item)
	
func can_drop_at(inventory_item: InventoryItem, x: int, y: int) -> bool:
	if x < 0 or y < 0:
		return false
	if x + inventory_item.item.width > width or y + inventory_item.item.height > height:
		return false
	for existingItem in get_children() as Array[InventoryItem]:
		if existingItem.item == inventory_item.item: continue
		if x < existingItem.item.x + existingItem.item.width and x + inventory_item.item.width > existingItem.item.x and y < existingItem.item.y + existingItem.item.height and y + inventory_item.item.height > existingItem.item.y:
			return false
	return true


func can_drop(inventory_item: InventoryItem) -> bool:
	var x = floor((inventory_item.global_position.x - global_position.x) / 32.0)
	var y = floor((inventory_item.global_position.y - global_position.y) / 32.0)
	return can_drop_at(inventory_item, x, y)
	
