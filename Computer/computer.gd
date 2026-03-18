extends CharacterBody2D

@onready var speed = GlobalSettings.get_cpu_speed()
var ball
var dragging := false
var last_y: float
var target_y: float

func _ready():
	ball = get_parent().get_node("Ball")
	target_y = global_position.y
	
func _physics_process(delta):
	if GlobalSettings.is_multiplayer:
		# MODO MULTIJUGADOR: Controlado por humano (mitad derecha)
		global_position.y = lerp(global_position.y, target_y, 0.25)
	else:
		# MODO SINGLE PLAYER: Inteligencia Artificial
		speed = GlobalSettings.get_cpu_speed()
		# ... (AI logic)
		if abs(ball.position.y - position.y) < 10 : return
		var dir = -1 if ball.position.y < position.y else 1
		velocity.y = dir * speed
		move_and_collide(velocity * delta) 

func _unhandled_input(event):
	if not GlobalSettings.is_multiplayer: return
	
	if event is InputEventScreenTouch:
		# Solo responder en la mitad derecha (x > 640)
		if event.position.x < 640: return
		
		if event.pressed:
			dragging = true
			last_y = event.position.y
			# No necesitamos check de cercanía para P2 si la zona es grande, 
			# pero lo ideal es que al menos toque cerca de la altura
			target_y = event.position.y
		else:
			dragging = false

	elif event is InputEventScreenDrag and dragging:
		if event.position.x < 640: return
		target_y += (event.position.y - last_y)
		last_y = event.position.y
		target_y = clamp(target_y, 80, 640) # Limites rapidos
