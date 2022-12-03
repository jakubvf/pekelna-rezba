extends KinematicBody2D

var velocity : Vector2
export var speed : float

func _process(delta):
	var dir = Vector2.ZERO
	if Input.is_action_pressed("up"):
		dir.y -= speed
	if Input.is_action_pressed("down"):
		dir.y += speed
	if Input.is_action_pressed("left"):
		dir.x -= speed
	if Input.is_action_pressed("right"):
		dir.x += speed
	velocity += dir.normalized() * speed
	

func _physics_process(delta):
	velocity = move_and_slide(velocity)
