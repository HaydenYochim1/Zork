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
# TODO: iterate through area folder to get RoomSaveData for all rooms
func init(path: String = "") -> void:
	var areas = ResourceLoader.list_directory("res://Areas")
	for area_folder in areas:
		var rooms = ResourceLoader.list_directory("res://Areas/" + area_folder)
		for area in rooms:
			room_data["res://Areas/"] = RoomSaveData.new()
	if path != "":
		for key in room_data.keys():
			var room = room_data[key] as RoomSaveData
			room.load_data_from_file(path)
	else:
		print("No save data file")
