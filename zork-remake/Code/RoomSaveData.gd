class_name RoomSaveData extends Resource

@export var enemies_defeated_ids: Array[int] #only track enemies if they are defeated, may be updated in the future
@export var items_in_room: PackedVector3Array # id and coordinates
@export var items_used_ids: Array[int] # id of any items that have been used

@export var data_loaded: bool

func _init():
	data_loaded = false

func load_data_from_scene(root: Node2D) -> void:
	if data_loaded:
		return
	
	for node in root.get_children():
		if node is Item:
			var item = node as Item
			items_in_room.append(Vector3(item.id, item.global_position.x, item.global_position.y))
	data_loaded = true
			
# these three methods should connect to the enemy/item classes via signals
func on_enemy_defeat(enemy_id: int) -> void:
	enemies_defeated_ids.append(enemy_id)

func on_item_pickup(item_id: int) -> void:
	items_in_room.remove_at(find_item_in_room(item_id))
	
func on_item_drop(item_id: int, coords: Vector2) -> void:
	items_in_room.append(Vector3(item_id, coords.x, coords.y))
	
func on_item_use(item_id: int):
	items_used_ids.append(item_id)
	
func find_item_in_room(id: int) -> int:
	for i in range(items_in_room.size()):
		if items_in_room.get(i).x == id:
			return i
	
	#not found, return -1
	return -1
