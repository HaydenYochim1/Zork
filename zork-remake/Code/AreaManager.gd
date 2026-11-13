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
	hotbar.z_index = 3
	
	const ig = preload("res://Objects/inventory_gui.tscn")
	var inventoryGUI = ig.instantiate()
	after_startup.connect(inventoryGUI.startup)
	add_child(inventoryGUI)
	inventoryGUI.z_index = 3
	
	const hg = preload("res://Objects/HealthGUI.tscn")
	var healthGUI = hg.instantiate()
	after_startup.connect(healthGUI.startup)
	add_child(healthGUI)
	healthGUI.z_index = 3
	
	
	
	if FileAccess.file_exists("user://savedata.tres"):
		Global.start("user://savedata.tres")
		after_startup.emit()
		if !(scene_file_path in Global.room_data.keys()):
			print("Warning: this scene is not in the proper location, move it for full functionality!")	
			return
	else:
		Global.start()
		after_startup.emit()
		if !(scene_file_path in Global.room_data.keys()):
			print("Warning: this scene is not in the proper location, move it for full functionality!")	
			return
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
