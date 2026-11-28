extends Item

class_name Lantern

var point_light: PointLight2D

func use() -> void:
	print("children: ", get_children(), " scene: ", scene_file_path)
	var player = (Engine.get_main_loop() as SceneTree).get_first_node_in_group("player")
	if player == null:
		push_warning("No node in group 'player'")
		return

	var light = get_node_or_null("PointLight2D")
	if light == null:
		push_warning("Lantern has no PointLight2D child")
		return

	if get_parent() != player:
		if get_parent():
			get_parent().remove_child(self)
		player.add_child(self)
		position = Vector2.ZERO
		show()                
		self_modulate.a = 0.0 
		light.visible = true
		return

	light.visible = !light.visible
