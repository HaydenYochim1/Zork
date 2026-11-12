extends Resource

class_name Inventory

signal updated

@export var slots: Array[InventorySlot]

func _init():
	for i in range(20):
		slots.append(InventorySlot.new())
		
func insert(item: ItemResource):
	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = item
			break

	updated.emit()
	
func remove_slot(inventory_slot: InventorySlot):
	var index = slots.find(inventory_slot)
	if index < 0: return
	
	slots[index] = InventorySlot.new()
	updated.emit()

func remove_item_at_index(idx):
	slots[idx] = InventorySlot.new()
	
func insert_slot(idx, inventory_slot: InventorySlot):
	var old_idx = slots.find(inventory_slot)
	remove_item_at_index(old_idx)
	
	slots[idx] = inventory_slot
	updated.emit()
