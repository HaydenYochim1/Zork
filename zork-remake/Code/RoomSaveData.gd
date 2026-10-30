class_name RoomSaveData extends Resource

@export var enemies_defeated_ids: Array[int] #only track enemies if they are defeated, may be updated in the future
@export var items_in_room: PackedVector3Array # id and coordinates
@export var items_used_ids: Array[int] # id of any items that have been used

func load_data_from_scene(path: String) -> void:
	var root: Node2D = load(path).instantiate()
	for node in root.get_children():
		if node is Item:
			var item = node as Item
			items_in_room.append(Vector3(item.id, item.global_position.x, item.global_position.y))
			
func load_data_from_file(path: String) -> void:
	ResourceSaver.save(self, path)
	
		
	
func save_data_to_file(path: String) -> void:
	ResourceLoader.load(path, "RoomSaveData")

func _on_enemy_defeat(enemy_id: int) -> void:
	enemies_defeated_ids.append(enemy_id)

func _on_item_pickup(item_id: int, coords: Vector2) -> void:
	items_in_room.remove_at(items_in_room.find(Vector3(item_id, coords.x, coords.y)))
