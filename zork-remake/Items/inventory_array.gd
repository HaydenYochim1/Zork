extends Node


# Called when the node enters the scene tree for the first time.
@export var inventory = []

var upperLimit = 0
var index = 0
func _ready() -> void:
	pass
func _incrementUpperLimit():
	upperLimit = upperLimit + 1

func _decrementUpperLimit():
	upperLimit = upperLimit - 1


func _input(event):
	#index inventory
	if event is InputEventKey and event.is_action_pressed("ui_up") and index < upperLimit - 1: #event.is_action_pressed(""): #use arrow up to index up
		index = index + 1 
		#print(index)
		print(inventory)
	elif event is InputEventKey and event.is_action_pressed("ui_down") and index > 0: #use arrow down to index down
		index = index - 1
		#print(index)
		print(inventory)
	elif event.is_action_pressed("Drop"):
		_drop_selected_item()
		print(inventory)
	elif event.is_action_pressed("UseItem"):
		_useItem()
		print("using Item")
	#if(event is InputEventKey):
	#	inventory[index]._input
func _drop_selected_item() -> void:
	if inventory.is_empty():
		return
		
	index = clampi(index, 0, inventory.size() - 1)
	var item = inventory[index]
	item.show()
	item.set("vis", true)
	item.global_position = item.get_global_mouse_position()
	inventory.remove_at(index)

	# Keep the index within the remaining inventory.
	if inventory.is_empty():
		index = 0
	else:
		index = clampi(index, 0, inventory.size() - 1)
		print("Dropped: ", item.name)
		print("Items remaining: ", inventory.size())
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _useItem() -> void:
	if inventory.is_empty():
		return
		
	index = clampi(index, 0, inventory.size() - 1)
	var item = inventory[index]
	
	item._use()
	
func _process(delta: float) -> void:
	pass
