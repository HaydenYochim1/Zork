@tool
extends Area2D

@export_file("*.tscn") var next_scene_path: String
@export var spawn_player_at: Vector2
@export var player_spawn_Direction: Global.PlayerFacingDecrection
# Colider Size
@export var size := Vector2(32, 32):
	set(value):
		size = value
		_update_shape()


func change_level():
	if next_scene_path != "":
		get_tree().change_scene_to_file(next_scene_path)
	else:
		push_error("Next scene path is not set in the Inspector!")

func _update_shape() -> void:
	var collision := get_node_or_null("CollisionShape2D") as CollisionShape2D
	if collision == null:
		push_error("ERROR: Portal CollisionShape2D not found or is missing. cannot update portal collider shape")
		return
	var rect := RectangleShape2D.new()
	rect.size = size
	collision.shape = rect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_shape()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	Global.player_initial_map_position = spawn_player_at
	
	if get_tree().change_scene_to_file(next_scene_path) != OK :
		push_error("Error Scene change failed on object Portal.")
	pass # Replace with function body.
