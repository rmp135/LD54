extends Control

func on_item_dropped(item: InventoryItem):
	var invs = get_tree().get_nodes_in_group("inventory") as Array[Inventory]
	var foundInv : Inventory = null
	for i in invs:
		if i.can_drop(item):
			foundInv = i
			break
	if foundInv != null:
		foundInv.add_item(item)
	else:
		item.position = item.orig_position
