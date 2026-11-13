extends Node2D

@onready var hearts = [$AliveHeart, $AliveHeart2, $AliveHeart3]
var camera: Camera2D

func startup():
	camera = get_node("../Camera")
	if camera == null:
		print("Warning: could not find camera for UI to mount to!")
	
func _process(delta: float):
	if camera:
		global_position = camera.global_position + Vector2(380, -250)
		
	for i in range(3):
		if Global.player_health > i:
			hearts[i].show()
		else:
			hearts[i].hide()
		
