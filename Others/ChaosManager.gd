extends Node2D

@onready var label = $CanvasLayer/Label
@onready var timer = $Timer
@onready var chaos_ball_scene = preload("res://Others/ChaosBall.tscn")

func _ready():
	label.hide()
	timer.wait_time = GlobalSettings.chaos_interval
	timer.start()

func _on_timer_timeout():
	if not GlobalSettings.is_chaos_enabled: 
		timer.start(GlobalSettings.chaos_interval) # Seguir intentando
		return
	_start_countdown()

func _start_countdown():
	label.show()
	label.scale = Vector2.ZERO
	
	for i in range(3, 0, -1):
		label.text = str(i)
		_animate_text()
		await get_tree().create_timer(1.0).timeout
	
	label.text = "¡CAOS!"
	_animate_text()
	_spawn_chaos()
	
	await get_tree().create_timer(1.0).timeout
	label.hide()
	
	# Reiniciar ciclo según ajuste
	timer.start(GlobalSettings.chaos_interval)

func _animate_text():
	label.scale = Vector2(0.5, 0.5)
	var tw = create_tween()
	tw.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tw.tween_property(label, "scale", Vector2(1.5, 1.5), 0.4)
	tw.tween_property(label, "scale", Vector2(1.0, 1.0), 0.2)

func _spawn_chaos():
	for i in range(5): # Aumentado a 5 pelotas
		var ball = chaos_ball_scene.instantiate()
		ball.speed = 600.0 # Más rápidas
		# Aparecer dentro del campo para evitar que se salgan
		ball.position = Vector2(randf_range(150, 1130), 120)
		get_parent().add_child(ball)

func stop_chaos():
	timer.stop()
	label.hide()
	get_tree().call_group("active_chaos_objects", "queue_free")

func restart_chaos():
	stop_chaos()
	timer.start(GlobalSettings.chaos_interval)
