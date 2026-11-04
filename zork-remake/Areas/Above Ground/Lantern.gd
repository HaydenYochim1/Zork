extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
var vis = true #set false for items that are invisible until conditions are met
var is_moving = false
var move_speed = 200
var target_position = Vector2.ZERO
var animation_time = 0.5
var is_in_use = false
var inventory_position = Vector2.ZERO
@onready var inventoryArray = get_node("../InventoryArray")
@onready var LanternLight = get_node("res://Areas/point_light_2d.gd")
#var upperLimit = InventoryArray.upperLimit
func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			if vis:
				#pickup item not in inventory
				hide() #take off map
				vis = false #define visibility
				#print("test Node 2") #testing print, delete in prod
				
				inventoryArray._incrementUpperLimit()
				inventoryArray.inventory.append(self)
		
			#else:
				#pickup item that is already in inventory
				#print("test Node 2") #Testing print, delete in prod
	#if event is InputEventKey and event.is_action_pressed("Drop"): #on drop keybind
	#	if vis == false: #check bool
	#		#dropping item from inventory
	#		print("testing Node 2") #testing print, delete in prod
	#		show() #set visible
	#		vis = true #control visibility with boolean
	#		global_position = get_global_mouse_position() #Replace mouse position with player position for implementation
	#		inventoryArray._decrementUpperLimit()
	#		inventoryArray.inventory.erase(self)
	#	else:
	#		print("testing case Node 2") #Testing print, delete in prod
	#		# attempting to drop item that is not in inventory
	
func _use() -> void:
	if is_in_use:
		return
	is_in_use = true
	
	vis = true
	show()
	inventory_position = global_position
	print("in motion")
	var target_position = get_global_mouse_position()
	LanternLight._toggleLantern()
	print("in use")
	hide()
	is_in_use = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
