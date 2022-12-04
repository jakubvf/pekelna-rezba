extends KinematicBody2D

export var speed : float

var velocity : Vector2

func _process(delta):
	var frame_movement_direction = Vector2.ZERO
	if Input.is_action_pressed("up"):
		frame_movement_direction.y -= speed
	if Input.is_action_pressed("down"):
		frame_movement_direction.y += speed
	if Input.is_action_pressed("left"):
		frame_movement_direction.x -= speed
	if Input.is_action_pressed("right"):
		frame_movement_direction.x += speed
	velocity += frame_movement_direction.normalized() * speed
	
	look_at(get_global_mouse_position())
	


func _physics_process(delta):
	velocity = move_and_slide(velocity)
