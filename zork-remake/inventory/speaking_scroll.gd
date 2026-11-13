extends Collectable

var vis = true
#@onready var inventory_array = get_node("../InventoryArray")

func use():
	print("talking")



"""
func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if vis and get_rect().has_point(get_local_mouse_position()):
			hide()
			vis = false
			inventory_array._incrementUpperLimit()
			inventory_array.inventory.append(self)
			
	if event.is_action_pressed("use"):
		if not vis:
			use()
	
"""	
