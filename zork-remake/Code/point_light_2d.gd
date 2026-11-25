extends PointLight2D

@export var Lantern = false;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _toggleLight() -> void:
	if (Lantern):
		Lantern = false;
		hide()
	else:
		Lantern = true;
		show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
