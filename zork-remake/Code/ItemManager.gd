class_name ItemManager extends Node2D

# all items and their id's will be stored in here
var items: Dictionary = {
	0: Item.new("res://Assets/item_placeholder.jpg"),
	1: Item.new("res://Assets/speaking_scroll_sprite.png")
}

var item_names: Dictionary = {
	0: "Placeholder",
	1: "Speaking Scroll"
}

func load_items() -> void:
	var root_path = get_tree().current_scene.scene_file_path
	var room_save_data = Global.room_data[root_path]
	
	#load items in in the save data for the scene
	for item_data in room_save_data.items_in_room:
		var item_to_add = items[int(item_data.x)] # get item from id
		item_to_add.global_position.x = item_data.y
		item_to_add.global_position.y = item_data.z
		item_to_add.name = item_names[int(item_data.x)]
		item_to_add.id = int(item_data.x)
		get_tree().current_scene.add_child.call_deferred(item_to_add)
	
func remove_items():
	var root_path = get_tree().current_scene.scene_file_path
	var room_save_data = Global.room_data[root_path]
	for node in get_tree().current_scene.get_children():
		if node is Item:
			var item = node as Item
			if room_save_data.find_item_in_room(item.id) < 0:
				node.queue_free()
