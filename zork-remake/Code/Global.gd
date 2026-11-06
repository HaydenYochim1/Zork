extends Node

enum PlayerFacingDecrection {
	NORTH = 0,
	EAST = 1,
	SOUTH = 2,
	WEST = 3
}
var defult_player_spawn:= Vector2.ZERO

# The players spwan location and facing direction in the map when loaded.
var player_initial_map_position = Vector2(defult_player_spawn) #TODO: have this update to the last player posision in the save file and if new save, update to spwaning pos.
var player_initial_facing_direction = PlayerFacingDecrection.NORTH

# TODO: Remove var loading_zone_id below when it has been deprocated fully.
var loading_zone_id: int = -1

# Dictionary to keep track of data in each room
var room_data : Dictionary = {}

func init(path: String = "") -> String:
	# if no path, start new save file by initializing room_data
	if path == "":
		var areas = ResourceLoader.list_directory("res://Areas")
		for area_folder in areas:
			var rooms = ResourceLoader.list_directory("res://Areas/" + area_folder)
			for area in rooms:
				room_data["res://Areas/"] = RoomSaveData.new()
		return "res://Areas/Above Ground/ White House Outside.tscn"
	# if there is a path, load save data into room_data
	else:
		var save_data := ResourceLoader.load(path, "DataSaver") as DataSaver
		room_data = save_data.rooms
		return save_data.current_scene_path
			
func save(save_path: String, scene_path: String) -> void:
	var save_data = DataSaver.new()
	save_data.current_scene_path = scene_path
	save_data.rooms = room_data
	ResourceSaver.save(save_data, save_path)
	
