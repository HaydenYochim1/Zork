extends Node2D

# all items and their id's will be stored in here
var items: Dictionary = {
	0: Item.new("res://Assets/item_placeholder.jpg")
}

func _ready() -> void:
	var room_save_data = Global.room_data[get_tree().current_scene.scene_file_path]
	for item_data in room_save_data.items_in_room:
		var item_to_add = items[item_data.x] # get item from id
		item_to_add.global_position.x = item_data.y
		item_to_add.global_position.y = item_data.z
		get_tree().add_child(item_to_add)
