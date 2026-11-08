extends HBoxContainer

@onready var inventory: Inventory = preload("res://inventory/items/player_inventory.tres")
@onready var slots: Array = get_children()
var selected = 0

func _input(event):
	if not is_visible_in_tree(): return
	
	if event.is_action_pressed("use"):
		var selected_slot = inventory.slots[selected + find_offset()]
		if selected_slot.item:
			selected_slot.item.use() 
	
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode in range(KEY_1, KEY_6):
			selected = event.keycode - KEY_1
			update()
		

func _ready() -> void:
	update()
	inventory.updated.connect(update)


func update():
	var offset = find_offset()
	for i in range(slots.size()):
		var inventory_slot: InventorySlot = inventory.slots[i + offset]
		slots[i].update_to_slot(inventory_slot)
		slots[i].set_selected(i == selected)
		
func find_offset():
	return inventory.slots.size() - slots.size()
