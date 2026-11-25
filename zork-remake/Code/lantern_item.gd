extends Item

class_name Lantern

@onready var point_light: PointLight2D = $PointLight2D

func use():
	point_light.visible = !point_light.visible
