extends StaticBody2D

var trophies: Array[ItemResource]
var open: bool

@onready var gui = $TrophyCaseGUI
var player: CharacterBody2D

func _ready():
	player = get_node("../Player")
	if !player:
		print("No player found!")
	open = false
	gui.hide()
	for i in range(20):
		var ir = ItemResource.new()
		var img = Image.new()
		img.load("res://Assets/speaking_scroll_sprite.png")
		ir.texture = ImageTexture.create_from_image(img)
		trophies.append(ir)

func view():
	if open:
		return
	var cam = get_node("../Camera")
	if cam:
		gui.global_position = cam.global_position
	else:
		print("No Camera for the gui to follow!")
	open = true
	var x = -175
	var y = -150
	for trophy in trophies:
		var sprite = Sprite2D.new()
		sprite.texture = trophy.texture
		sprite.position = Vector2(x, y)
		sprite.scale = Vector2(2, 2)
		gui.add_child(sprite)
		x += 85
		if x > 200:
			x = -175
			y += 110
	gui.show()
		

func close():
	gui.hide()
	if !open:
		return
	open = false
	for trophy in gui.get_children():
		trophy.queue_free()
	
func put(trophy: ItemResource):
	#TODO: double check that item is trophy
	trophies.append(trophy)
	if open:
		close()
		view()
	if (trophies.size() >= 19):
		print("all trophies collected")

func _input(event: InputEvent):
	if !player:
		return
	
	if event.is_action_pressed("trophy_case"):
		if open:
			close()
		elif player.global_position.x > global_position.x - 100 and player.global_position.y > global_position.y - 100:
			view()
