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
		if delta == 0: return # Para evitar primer frame raro
		speed = GlobalSettings.get_cpu_speed()
		
		# Proactive AI: Prevenir "dormirse" con seguimiento más suave y agresivo
		var ball_y = ball.global_position.y
		var dist = ball_y - global_position.y
		
		# Dead-zone reducida a 4px para precisión
		if abs(dist) < 4:
			velocity.y = move_toward(velocity.y, 0, speed * delta * 10)
		else:
			# Seguir la pelota con aceleración
			var target_vel = sign(dist) * speed
			# Reacciona más rápido si la pelota viene hacia el CPU
			var reaction_mult = 1.0
			if (ball.velocity.x > 0): reaction_mult = 1.5
			
			velocity.y = move_toward(velocity.y, target_vel, speed * delta * 8.0 * reaction_mult)
		
		move_and_collide(velocity * delta)
		# Clamp para no salir de pantalla (mejorado para no trabarse en bordes)
		global_position.y = clamp(global_position.y, 60, 660)

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
