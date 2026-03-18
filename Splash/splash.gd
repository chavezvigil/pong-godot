extends Control

@onready var studio_label = $Center/VBox/StudioName
@onready var glow = $Center/VBox/StudioName/Glow

func _ready():
	# Inicializar estados
	studio_label.modulate.a = 0.0
	studio_label.scale = Vector2(0.9, 0.9)
	studio_label.pivot_offset = studio_label.size / 2
	
	glow.scale.x = 0.0
	
	_animate_splash()

func _animate_splash():
	var tw = create_tween().set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	
	# 1. Fade in y escala del texto
	tw.tween_property(studio_label, "modulate:a", 1.0, 1.2)
	tw.parallel().tween_property(studio_label, "scale", Vector2(1.0, 1.0), 1.5)
	
	# 2. Expansion del brillo horizontal
	tw.tween_property(glow, "scale:x", 1.0, 0.8)
	
	# 3. Esperar y salir
	tw.tween_interval(1.5)
	tw.tween_property(self, "modulate:a", 0.0, 0.8)
	
	tw.tween_callback(func(): get_tree().change_scene_to_file("res://Menu/menu.tscn"))

func _process(_delta):
	# Efecto de pulso muy sutil en el brillo
	if studio_label.modulate.a > 0.5:
		glow.modulate.a = 0.3 + sin(Time.get_ticks_msec() * 0.005) * 0.1
