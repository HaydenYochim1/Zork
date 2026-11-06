class_name Item extends Sprite2D

@export var id: int


var image_path: String

func _init(ipath := texture.resource_path):
	image_path = ipath

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = ImageTexture.create_from_image(Image.load_from_file(image_path))
