extends CharacterBody2D

var speed := 400.0
var direction := Vector2.ZERO

func _ready():
	add_to_group("active_chaos_objects")
	# Dirección inicial aleatoria (principalmente hacia abajo)
	direction = Vector2(randf_range(-1.0, 1.0), randf_range(0.5, 1.0)).normalized()
	
	# Color aleatorio para "emoción"
	modulate = Color(randf(), randf(), randf(), 0.8)
	
	# Auto-destrucción tras 20 segundos
	var tw = create_tween()
	tw.tween_interval(20.0)
	tw.tween_property(self, "modulate:a", 0.0, 0.5)
	tw.tween_callback(queue_free)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		direction = direction.bounce(collision.get_normal())
		
		# Si choca con la pelota principal, afectarla
		var collider = collision.get_collider()
		if collider.name == "Ball":
			# Pasar la normal del choque para un rebote realista
			_affect_main_ball(collider, collision.get_normal())

func _affect_main_ball(ball: CharacterBody2D, normal: Vector2):
	# Cambiar la dirección de la pelota de forma brusca
	if ball.has_method("apply_chaos_hit"):
		ball.call("apply_chaos_hit", normal)
