extends Panel

class_name ItemStackGUI

@onready var item_sprite: Sprite2D = $item

var inventory_slot

func update():
	if !inventory_slot || !inventory_slot.item: return
	item_sprite.visible = true
	item_sprite.texture = inventory_slot.item.texture
	
