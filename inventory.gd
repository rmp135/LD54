class_name Inventory
extends TextureRect

@export var width := 10
@export var height := 10

@export var items : Array[Item] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var icon = preload("res://inventory_item.tscn")
	resize()
	
	for item in items:
		var n = icon.instantiate()
		n.item = item
		n.dropped.connect(get_parent().on_item_dropped)
		n.on_hover.connect(get_tree().root.get_node("Main/Hovered").on_hovered)
		n.on_unhover.connect(get_tree().root.get_node("Main/Hovered").on_unhovered)
		
		add_child(n)
		
func clear_items():
	for c in get_children():
		remove_child(c)

func resize():
	size.x = width * 32
	size.y = height * 32

func add_item(icon: InventoryItem):
	var x = floor((icon.global_position.x - global_position.x) / 32.0)
	var y = floor((icon.global_position.y - global_position.y) / 32.0)
	add_item_at(icon, x, y)

func add_item_at(icon: InventoryItem, x: int, y: int):
	icon.item.x = x
	icon.item.y = y
	icon.position = Vector2(x * 32, y * 32)
	if icon.get_parent() != null:
		icon.get_parent().remove_child(icon)
	add_child(icon)
	
func can_drop_at(icon: InventoryItem, x: int, y: int) -> bool:
	if x < 0 or y < 0:
		return false
	if x + icon.item.width > width or y + icon.item.height > height:
		return false
	for existingItem in get_children() as Array[InventoryItem]:
		if existingItem.item == icon.item: continue
		if x < existingItem.item.x + existingItem.item.width and x + icon.item.width > existingItem.item.x and y < existingItem.item.y + existingItem.item.height and y + icon.item.height > existingItem.item.y:
			return false
	return true


func can_drop(icon: InventoryItem) -> bool:
	var x = floor((icon.global_position.x - global_position.x) / 32.0)
	var y = floor((icon.global_position.y - global_position.y) / 32.0)
	return can_drop_at(icon, x, y)
	
