extends CanvasLayer

@onready var item_list: ItemList = $PanelContainer/ItemList
@onready var test_inventory_player: CharacterBody2D = $"../TestInventory"
@onready var player: CharacterBody2D = $"../Player"

func _input(event):
	if event.is_action_pressed("inventory"):
		visible = not visible
		player.can_move = not visible
		if visible:
			refresh()
	
	if event.is_action_pressed("Drop"):
		refresh()
	
	
func refresh():
	if player == null:
		return
		
	var inventory_array = test_inventory_player.get_node("InventoryArray")
	
	item_list.clear()
	
	for item in inventory_array.inventory:
		item_list.add_item(item.name)
		
