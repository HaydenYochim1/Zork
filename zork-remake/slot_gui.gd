extends Button


@onready var background_sprite: Sprite2D = $background
@onready var container: CenterContainer = $CenterContainer

@onready var inventory = preload("res://inventory/items/player_inventory.tres")

var item_stack_gui: ItemStackGUI
var index: int

func insert(isg: ItemStackGUI):
	item_stack_gui = isg
	background_sprite.frame = 1
	container.add_child(item_stack_gui)
	
	if !item_stack_gui.inventory_slot or inventory.slots[index] == item_stack_gui.inventory_slot:
		return
	
	inventory.insert_slot(index, item_stack_gui.inventory_slot)

func take_item():
	var item = item_stack_gui
	
	container.remove_child(item_stack_gui)
	item_stack_gui = null
	background_sprite.frame = 0
	
	return item

func is_empty():
	return !item_stack_gui

func clear_item():
	background_sprite.frame = 0
	if !item_stack_gui: return
	item_stack_gui.queue_free()
	item_stack_gui = null
