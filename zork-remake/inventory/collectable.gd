extends Area2D
class_name Collectable

@export var item_res: InventoryItem

func _ready():
	if !item_res: return
	$Sprite2D.texture = item_res.texture

func collect(inventory: Inventory):
	print("collected")
	#inventory.insert(item_res)
	queue_free()
	
