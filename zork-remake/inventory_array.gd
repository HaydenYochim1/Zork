extends Node


# Called when the node enters the scene tree for the first time.
var inventory = []
var index = 0
func _ready() -> void:
	
	pass # Replace with function body.

func input(event):
	#index inventory
	if event is InputEventKey and event.is_action_pressed("ui_up"): #event.is_action_pressed(""): #use arrow up to index up
		index = index + 1
		print(index)
		print(inventory[index])
	if event is InputEventKey and event.is_action_pressed("ui_down"): #use arrow down to index down
		index = index - 1
		print(index)
		print(inventory[index])
	if event is InputEventKey and event.is_action_pressed(""): #indicate button for use
		inventory[index] 
	






# This typed array can only contain integers.
# Attempting to add any other type will result in an error.
var typed_array: Array[int] = [1, 2, 3]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
