extends Node

enum PlayerFacingDecrection {
	NORTH = 0,
	EAST = 1,
	SOUTH = 2,
	WEST = 3
}
var defult_player_spawn:= Vector2(524,119)

# The players spwan location and facing direction in the map when loaded.
var player_initial_map_position = Vector2(defult_player_spawn) #TODO: have this update to the last player posision in the save file and if new save, update to spwaning pos.
var player_facing_direction = PlayerFacingDecrection.NORTH

# TODO: Remove var loading_zone_id below when it has been deprocated fully.
var loading_zone_id: int = -1
