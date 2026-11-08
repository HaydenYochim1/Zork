extends Control

@onready var player: CharacterBody2D = $"../Player"
var is_open = false
@onready var inventory: Inventory = preload("res://inventory/items/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var item_stack_gui_class = preload("res://inventory/item_stack_gui.tscn")
@onready var hotbar: HBoxContainer = $"../Hotbar"
@onready var collectable_scene = preload("res://collectable.tscn")


var item_in_hand: ItemStackGUI

func _ready():
	connect_slots()
	inventory.updated.connect(update)
	close()
	update()
	
func connect_slots():
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		
		var callable = Callable(on_slot_clicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)
	
func update():
	for i in range(min(inventory.slots.size(), slots.size())):
		var inventory_slot = inventory.slots[i]
		
		if !inventory_slot.item: 
			slots[i].clear_item()
			continue
		
		var item_stack_gui: ItemStackGUI = slots[i].item_stack_gui
		if !item_stack_gui:
			item_stack_gui = item_stack_gui_class.instantiate()
			slots[i].insert(item_stack_gui)
		
		item_stack_gui.inventory_slot = inventory_slot
		item_stack_gui.update()

func open():
	visible = true
	is_open = true
	player.can_move = false
	
func close():
	visible = false
	is_open = false
	player.can_move = true
	
func _input(event):
	if is_open and event.is_action_pressed("drop"):
		drop_hovered_item()
	
	if event.is_action_pressed("inventory"):
		if is_open:
			close()
			hotbar.visible = true
		else:
			open()
			hotbar.visible = false
	update_item_in_hand()
			
func on_slot_clicked(slot):
	if slot.is_empty() and item_in_hand:
		insert_item_in_slot(slot)
		return
	
	if !item_in_hand:
		take_item_from_slot(slot)
	
func take_item_from_slot(slot):
	item_in_hand = slot.take_item()
	add_child(item_in_hand)
	update_item_in_hand()
	
func insert_item_in_slot(slot):
	var item = item_in_hand
	
	remove_child(item_in_hand)
	item_in_hand = null
	
	slot.insert(item)
	
func update_item_in_hand():
	if !item_in_hand: return
	
	item_in_hand.global_position = get_global_mouse_position() - (item_in_hand.size / 2)

func drop_hovered_item():
	for i in range(slots.size()):
		if !slots[i].is_hovered(): continue
		if !inventory.slots[i].item: return
		
		var item = inventory.slots[i].item
		inventory.remove_slot(inventory.slots[i])
		var drop = collectable_scene.instantiate()
		
		drop.item_res = item
		drop.global_position = player.global_position + Vector2(60, 0)
		get_tree().current_scene.add_child(drop)
		
		return
