@tool
extends Area2D

@export var player: CharacterBody2D
@export var teleport_player_to: Vector2

# Colider Size
@export var size := Vector2(32, 32):
	set(value):
		size = value
		_update_shape()


func teleport():
	if player != null:
		player.global_position = teleport_player_to
	else:
		push_error("player is not set in the Teleporter!")

func _update_shape() -> void:
	var collision := get_node_or_null("CollisionShape2D") as CollisionShape2D
	if collision == null:
		push_error("ERROR: Teleporter CollisionShape2D not found or is missing. cannot update teleporter collider shape")
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
	
	if teleport() != OK :
		push_error("Error Teleport failed on object Teleporter.")
