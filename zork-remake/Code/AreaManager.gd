extends Node2D

signal after_startup

signal data_done_loading

func _ready():
	if (get_node("ItemManager")) == null:
		print("No item manager!")
		return
	after_startup.connect(get_node("ItemManager").load_items)
	data_done_loading.connect(get_node("ItemManager").remove_items)
	
	const hb = preload("res://Objects/hotbar.tscn")
	var hotbar = hb.instantiate()
	hotbar.name = "HotBar"
	after_startup.connect(hotbar.startup)
	add_child(hotbar)
	
	const ig = preload("res://Objects/inventory_gui.tscn")
	var inventoryGUI = ig.instantiate()
	after_startup.connect(inventoryGUI.startup)
	add_child(inventoryGUI)
	
	if FileAccess.file_exists("user://savedata.tres"):
		Global.start("user://savedata.tres")
		after_startup.emit()
	else:
		Global.start()
		after_startup.emit()
		Global.room_data[scene_file_path].load_data_from_scene(self)
	
	data_done_loading.emit()
	
func _process(_delta: float):
	# for testing saving functionality
	if Input.is_action_pressed("test_save"):
		Global.save("user://savedata.tres", get_tree().current_scene.scene_file_path)
	if Input.is_action_pressed("test_load"):
		Global.player_initial_map_position = Vector2(0, 0)
		if FileAccess.file_exists("user://savedata.tres"):
			get_tree().change_scene_to_file(Global.start("user://savedata.tres"))
		else:
			get_tree().change_scene_to_file(Global.start())
