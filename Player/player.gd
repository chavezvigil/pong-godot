extends CharacterBody2D

var speed = 900
var dragging := false
var last_y := 0.0

func _physics_process(delta):
	velocity.y = 0
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1
	
	velocity.y *= speed
	move_and_collide(velocity * delta)

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			dragging = true
			last_y = event.position.y
		else:
			dragging = false
	
	elif event is InputEventScreenDrag and dragging:
		var delta_y = event.position.y - last_y
		position.y += delta_y
		last_y = event.position.y
