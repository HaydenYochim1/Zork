class_name Player extends CharacterBody2D

@export var speed := 300.0
@export var accel := 2000.0
@export var friction := 2000.0

# I feel like we will eventually need a variable to prevent moving
# for when your in the inventory for example. 
var can_move = true

# prevents enemies from inflicting damage every single frame
var in_iframes = false
var itime: float

func _ready() -> void:
	if Global.inventory != null:
		global_position = Global.player_initial_map_position # set the players pos on scene load5
	
		
func _physics_process(delta: float) -> void:
	
	if not can_move:
		velocity = Vector2.ZERO	
		move_and_slide()
		return
			
	var input_direction := Input.get_vector("left", "right", "up", "down")

	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(input_direction * speed, accel * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			
	move_and_slide()
	
	# blink if just took damage
	if in_iframes:
		itime += delta
		
		if int(100 * itime) % 10 < 5 :
			hide()
		else:
			show()
			
		if itime >= 3.0:
			in_iframes = false
			show()

func _on_hurt_box_area_entered(area: Area2D):
	if in_iframes:
		return
	#TODO: Check if area entered is enemy damage box
	Global.player_health -= 1
	in_iframes = true
	itime = 0.0
