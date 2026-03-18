extends Node2D

var CENTER = Vector2(640, 360)
var player_score = 0
var computer_score = 0

@onready var pause_scene = preload("res://Pause/popups.tscn")
var pause_menu

@onready var reset_scene = preload("res://Reset/reset.tscn")
var reset_menu

@onready var pause_button = $CanvasLayer/PauseButton
@onready var computerScore = $ComputerScore
@onready var playerScore = $PlayerScore
@onready var levelLabel = $LevelLabel

func _ready() -> void:
	# Aplicar temática al fondo y escalar para llenar la pantalla (1280x720)
	var bg_tex = load(GlobalSettings.get_background_path())
	if bg_tex:
		$Background.texture = bg_tex
		var target_size = Vector2(1280, 720)
		var tex_size = bg_tex.get_size()
		$Background.scale = target_size / tex_size
	
	# Especial ESPACIO: Estrellas y Nebulosas Procedurales
	if GlobalSettings.current_theme == 1:
		_setup_space_field()
	
	# Especial PLAYA: Horizonte Tropical Procedural
	if GlobalSettings.current_theme == 2:
		_setup_beach_field()
	
	# Especial FUTBOL: Añadir lineas de campo si no hay fondo
	if GlobalSettings.current_theme == 3:
		_setup_futbol_field()
	
	# Especial PACMAN: Fondo negro y lineas azules
	if GlobalSettings.current_theme == 4:
		_setup_pacman_field()
	
	if GlobalSettings.is_multiplayer:
		$LevelLabel.hide()
	
	# Añadir Audio Ambiental Procedural
	var music_script = load("res://Pong/AmbientAudio.gd")
	var music_player = AudioStreamPlayer.new()
	music_player.name = "AmbientAudio"
	music_player.set_script(music_script)
	add_child(music_player)
	
	player_score = GlobalSettings.puntos_max
	computer_score = GlobalSettings.puntos_max
	_update_ui()
	
	pause_menu = pause_scene.instantiate()
	add_child(pause_menu)
	
	reset_menu = reset_scene.instantiate()
	add_child(reset_menu)

func _update_ui():
	computerScore.text = str(computer_score)
	playerScore.text = str(player_score)
	levelLabel.text = "NIVEL " + str(GlobalSettings.current_level)
	
	

func _on_goal_left_body_entered(body: Node2D) -> void:
	player_score -= 1
	playerScore.text = str(player_score)
	set_game ()
	reset ()

func _on_goal_right_body_entered(body: Node2D) -> void:
	computer_score -= 1
	computerScore.text = str(computer_score)
	set_game ()
	reset ()
	
func reset () :
	$Ball.position = CENTER
	$Ball.call("set_ball_velocity")
	$Player.position.y = CENTER.y
	$Computer.position.y = CENTER.y
	
func set_game () :
	if (player_score == 0) or (computer_score == 0) :
		var resultado
		if (player_score > computer_score ):
			GlobalSettings.current_level += 1
			resultado = "!NIVEL " + str(GlobalSettings.current_level) + " ALCANZADO!"
		else:
			# Generar mensaje de logros al perder
			var logro = ""
			match GlobalSettings.current_theme:
				1: logro = "ASTRO-PONG"
				2: logro = "REY DE LA PLAYA"
				3: logro = "GOLEADOR"
				4: logro = "RETRO MASTER"
				_: logro = "LEYENDA CLASICA"
			
			if GlobalSettings.current_level > 5:
				logro += " ELITE"
			
			resultado = "FIN DEL JUEGO!\nLLEGASTE AL NIVEL: " + str(GlobalSettings.current_level) + "\nLOGRO: " + logro
			GlobalSettings.current_level = 1
		
		# --- GUARDADO DE RECORD (Si el nivel actual es mejor) ---
		if GlobalSettings.current_level > GlobalSettings.max_level_reached:
			GlobalSettings.max_level_reached = GlobalSettings.current_level
			# El logro se actualiza solo al perder para mostrar el rango final
			GlobalSettings.save_data()
		
		player_score = GlobalSettings.puntos_max
		computer_score = GlobalSettings.puntos_max
		_update_ui()
		
		hide_components()
		reset_menu.set_msg(resultado)
		reset_menu.show_menu()
		
			
func _on_touch_screen_button_pressed() -> void:
	pause_menu.show_menu()
	

# Función para ocultar el botón de pausa
func hide_components():
	pause_button.hide()
	computerScore.hide()
	playerScore.hide()

func _setup_futbol_field():
	# Cesped
	$Background.texture = null
	var grass = ColorRect.new()
	grass.mouse_filter = Control.MOUSE_FILTER_IGNORE
	grass.color = Color(0.1, 0.45, 0.2)
	grass.size = Vector2(1280, 720)
	grass.show_behind_parent = true
	add_child(grass)
	
	# Lineas de campo (Bordes)
	var border = ReferenceRect.new()
	border.mouse_filter = Control.MOUSE_FILTER_IGNORE
	border.editor_only = false
	border.border_color = Color(1,1,1,0.5)
	border.border_width = 4.0
	border.size = Vector2(1180, 640)
	border.position = Vector2(50, 40)
	add_child(border)
	
	# Circulo central
	var center_circle = Panel.new()
	center_circle.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0,0,0,0)
	style.border_width_left = 4
	style.border_width_top = 4
	style.border_width_right = 4
	style.border_width_bottom = 4
	style.border_color = Color(1,1,1,0.5)
	style.corner_radius_top_left = 100
	style.corner_radius_top_right = 100
	style.corner_radius_bottom_right = 100
	style.corner_radius_bottom_left = 100
	center_circle.add_theme_stylebox_override("panel", style)
	center_circle.size = Vector2(200, 200)
	center_circle.position = Vector2(640-100, 360-100)
	add_child(center_circle)

func _setup_pacman_field():
	# Fondo Negro
	$Background.texture = null
	var bg = ColorRect.new()
	bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	bg.color = Color(0, 0, 0)
	bg.size = Vector2(1280, 720)
	bg.show_behind_parent = true
	add_child(bg)
	
	# Bordes Azules Neon
	var border = ReferenceRect.new()
	border.mouse_filter = Control.MOUSE_FILTER_IGNORE
	border.editor_only = false
	border.border_color = Color(0.1, 0.2, 0.8)
	border.border_width = 8.0
	border.size = Vector2(1200, 660)
	border.position = Vector2(40, 30)
	add_child(border)
	
	# Linea Central con "pellets" (puntos)
	$MiddleLine.modulate = Color(0.1, 0.2, 0.8)

func _setup_space_field():
	# Borrar textura anterior
	$Background.texture = null
	
	# Fondo Negro profundo
	var space_bg = ColorRect.new()
	space_bg.mouse_filter = Control.MOUSE_FILTER_IGNORE
	space_bg.color = Color(0.01, 0.01, 0.05)
	space_bg.size = Vector2(1280, 720)
	space_bg.show_behind_parent = true
	add_child(space_bg)
	
	# Efecto de Nebulosa (Glow central)
	var nebula = Panel.new()
	nebula.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.1, 0.1, 0.4, 0.2)
	style.corner_radius_top_left = 500
	style.corner_radius_top_right = 500
	style.corner_radius_bottom_right = 500
	style.corner_radius_bottom_left = 500
	nebula.add_theme_stylebox_override("panel", style)
	nebula.size = Vector2(800, 400)
	nebula.position = Vector2(240, 160)
	add_child(nebula)

	# Estrellas de fondo (Lejanas)
	var stars = CPUParticles2D.new()
	stars.amount = 150
	stars.lifetime = 10.0
	stars.preprocess = 10.0
	stars.emission_shape = CPUParticles2D.EMISSION_SHAPE_RECTANGLE
	stars.emission_rect_extents = Vector2(640, 360)
	stars.position = Vector2(640, 360)
	stars.gravity = Vector2.ZERO
	stars.scale_amount_min = 0.5
	stars.scale_amount_max = 1.5
	stars.color = Color(1, 1, 1, 0.5)
	stars.show_behind_parent = true
	add_child(stars)

func _setup_beach_field():
	# Borrar textura estirada
	$Background.texture = null
	
	# Cielo (Degradado)
	var sky = ColorRect.new()
	sky.mouse_filter = Control.MOUSE_FILTER_IGNORE
	sky.color = Color(0.4, 0.7, 1.0)
	sky.size = Vector2(1280, 400)
	sky.show_behind_parent = true
	add_child(sky)
	
	# Sol
	var sun = Panel.new()
	sun.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var sun_style = StyleBoxFlat.new()
	sun_style.bg_color = Color(1.0, 0.9, 0.4)
	sun_style.corner_radius_top_left = 60
	sun_style.corner_radius_top_right = 60
	sun_style.corner_radius_bottom_right = 60
	sun_style.corner_radius_bottom_left = 60
	sun_style.shadow_color = Color(1.0, 0.8, 0.2, 0.5)
	sun_style.shadow_size = 20
	sun.add_theme_stylebox_override("panel", sun_style)
	sun.size = Vector2(120, 120)
	sun.position = Vector2(1000, 80)
	add_child(sun)

	# Mar
	var sea = ColorRect.new()
	sea.mouse_filter = Control.MOUSE_FILTER_IGNORE
	sea.color = Color(0.1, 0.6, 0.8)
	sea.size = Vector2(1280, 200)
	sea.position = Vector2(0, 400)
	sea.show_behind_parent = true
	add_child(sea)
	
	# Arena
	var sand = ColorRect.new()
	sand.mouse_filter = Control.MOUSE_FILTER_IGNORE
	sand.color = Color(0.9, 0.8, 0.5)
	sand.size = Vector2(1280, 120)
	sand.position = Vector2(0, 600)
	sand.show_behind_parent = true
	add_child(sand)
	
