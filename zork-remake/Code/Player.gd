extends CharacterBody2D

@export var speed := 300.0
@export var accel := 2000.0
@export var friction := 2000.0

# I feel like we will eventually need a variable to prevent moving
# for when your in the inventory for example. 
var can_move = true;

func _ready() -> void:
	self.global_position = Global.player_initial_map_position # set the players pos on scene load

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
	
