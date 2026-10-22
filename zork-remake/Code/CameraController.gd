extends Camera2D

@export var player: CharacterBody2D

@export var upper_left_bound: Vector2
@export var lower_right_bound: Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x = max(min(player.global_position.x, lower_right_bound.x - 575), upper_left_bound.x + 575)
	global_position.y = max(min(player.global_position.y, lower_right_bound.y - 325), upper_left_bound.y + 325)
	
	
