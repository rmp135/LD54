class_name InventoryManager
extends Node2D

@export var hover_controller : HoverController

func clear_inventory():
	($OtherInventory as Inventory).clear_items()

func generate_inventory(scenario: Scenario):
	($OtherInventory as Inventory).width = scenario.grid_width
	($OtherInventory as Inventory).height = scenario.grid_height
	$OtherInventory.resize()
	#$NinePatchRect/Label.text = scenario.name
	if scenario.items.is_empty(): return
	for i in 5:
		var itemToSpawn = scenario.items.pick_random()
		var itemInstance = Item.new(itemToSpawn)
		if randi_range(0, 1) == 0:
			var w = itemInstance.width
			itemInstance.width = itemInstance.height
			itemInstance.height = w
		var inventoryItemScene = preload("res://inventory_item.tscn")
		var inventory_item = inventoryItemScene.instantiate()
		
		inventory_item.dropped.connect(on_item_dropped)
		inventory_item.on_hover.connect(hover_controller.on_hovered)
		inventory_item.on_unhover.connect(hover_controller.on_unhovered)	
		inventory_item.hover_controller = hover_controller
		inventory_item.set_item(itemInstance)
		try_add_item($OtherInventory, inventory_item)

func try_add_item(inventory: Inventory, item: InventoryItem):
	for x in inventory.width:
		for y in inventory.height:
			if inventory.can_drop_at(item, x, y):
				inventory.add_item_at(item, x, y)
				return

func on_item_dropped(item: InventoryItem):
	var invs = get_tree().get_nodes_in_group("inventory") as Array[Inventory]
	hover_controller.show()
	var foundInv : Inventory = null
	for i in invs:
		if i.can_drop(item):
			foundInv = i
			break
	if foundInv != null:
		foundInv.add_item(item)
	else:
		item.position = item.orig_position
		item.item.width = item.orig_size.x
		item.item.height = item.orig_size.y
