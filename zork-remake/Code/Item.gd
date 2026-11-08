class_name Item extends Sprite2D

@export var id: int
var vis = true #set false for items that are invisible until conditions are met
var is_moving = false
var move_speed = 200
var target_position = Vector2.ZERO
var animation_time = 0.5
var is_in_use = false
var inventory_position = Vector2.ZERO

@export var image_path: String

func _init(ipath := image_path):
	image_path = ipath

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var img = Image.new()
	img.load(image_path)
	texture = ImageTexture.create_from_image(img)
	scale = Vector2(64, 64)/texture.get_size()

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(get_local_mouse_position()):
			if vis:
				#pickup item not in inventory
				hide() #take off map
				vis = false #define 
				Global.inventoryArray._incrementUpperLimit()
				var item_res = ItemResource.new()
				item_res.name = name
				item_res.id = id
				Global.inventoryArray.inventory.append(item_res)
				Global.room_data[get_tree().current_scene.scene_file_path].on_item_pickup(id)
	
func on_drop(coords: Vector2) -> void:
	Global.room_data[get_tree().current_scene.scene_file_path].on_item_drop(id, coords)
	
func use() -> void:
	if is_in_use:
		return
	is_in_use = true
	
	vis = true
	show()
	inventory_position = global_position
	print("in motion")
	var target_position = get_global_mouse_position()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"global_position",target_position,animation_time)
	
	print("in use")

	# Perform the item's action after reaching the target
	tween.tween_callback(perform_item_action)
	
func perform_item_action() -> void:
	print("Item used!")
	# Return the item to its inventory state
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"global_position",inventory_position,animation_time)
	tween.tween_callback(finish_use)
	
func finish_use() -> void:
	hide()
	is_in_use = false
func actionAnimation() -> void:
	print("in motion")
	var target_position = get_global_mouse_position()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"global_position",target_position,animation_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_moving:
		global_position = global_position.move_toward(target_position, move_speed * delta)
	if global_position.is_equal_approx(target_position):
		is_moving = false
