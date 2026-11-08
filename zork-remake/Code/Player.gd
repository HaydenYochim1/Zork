class_name Player extends CharacterBody2D

@export var speed := 300.0
@export var accel := 2000.0
@export var friction := 2000.0

@export var inventory: Inventory




signal data_done_loading
# I feel like we will eventually need a variable to prevent moving
# for when your in the inventory for example. 
var can_move = true

func _ready() -> void:
	self.global_position = Global.player_initial_map_position # set the players pos on scene load5
	if FileAccess.file_exists("user://savedata.tres"):
		Global.start("user://savedata.tres")
	else:
		Global.start()
		Global.room_data[get_tree().current_scene.scene_file_path].load_data_from_scene(get_tree().current_scene)
		print("no save file, loadbing")
	
	data_done_loading.connect(get_node("../ItemManager").remove_items)
	data_done_loading.emit()
	
	
		
func _physics_process(delta: float) -> void:
	
	if not can_move:
		velocity = Vector2.ZERO	
		move_and_slide()
		return
			
	var input_direction := Input.get_vector("left", "right", "up", "down")

	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(input_direction * speed, accel * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			
	move_and_slide()
	
	# for testing saving functionality
	if Input.is_action_pressed("test_save"):
		Global.save("user://savedata.tres", get_tree().current_scene.scene_file_path)
	if Input.is_action_pressed("test_load"):
		Global.player_initial_map_position = Vector2(0, 0)
		if FileAccess.file_exists("user://savedata.tres"):
			get_tree().change_scene_to_file(Global.start("user://savedata.tres"))
		else:
			get_tree().change_scene_to_file(Global.start())
	
func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)
