extends TileMapLayer

@export var player: CharacterBody2D
@export var loading_zone_areas: PackedStringArray
@export var entry_zones: Array[Area2D]


func _ready() -> void:
	if Global.loading_zone_id >= 0:
		player.global_position = entry_zones[Global.loading_zone_id].global_position

func _process(delta: float) -> void:
	check_area_change()
	

func check_area_change() -> void:
	var cell = local_to_map(to_local(player.global_position))
	var tile: Vector2 = get_cell_atlas_coords(cell)
	var nextArea: String
	Global.loading_zone_id = -1
	if (tile.x == 0 and tile.y == 1):
		nextArea = loading_zone_areas.get(0)
		Global.loading_zone_id = 0
	if (tile.x == 1 and tile.y == 2):
		nextArea = loading_zone_areas.get(1)
		Global.loading_zone_id = 1
	if (tile.x == 0 and tile.y == 2):
		nextArea = loading_zone_areas.get(2)
		Global.loading_zone_id = 2
	if (tile.x == 1 and tile.y == 1):
		nextArea = loading_zone_areas.get(3)
		Global.loading_zone_id = 3
	if (tile.x == 2 and tile.y == 1):
		nextArea = loading_zone_areas.get(4)
		Global.loading_zone_id = 4
	if (tile.x == 2 and tile.y == 2):
		nextArea = loading_zone_areas.get(5)
		Global.loading_zone_id = 5
		
	if (Global.loading_zone_id >= 0):
		get_tree().change_scene_to_file(nextArea)
