extends CanvasLayer

@onready var item_list: ItemList = $PanelContainer/ItemList
@export var player: CharacterBody2D

func _input(event):
	if event.is_action_pressed("inventory"):
		visible = not visible
		player.can_move = not visible
		refresh()
	
	if event.is_action_pressed("Drop"):
		refresh()
	
	
func refresh():
	if player == null:
		return
		
	var inventory_array = Global.inventoryArray
	
	item_list.clear()
	
	for item in inventory_array.inventory:
		item_list.add_item(item.name)
		
