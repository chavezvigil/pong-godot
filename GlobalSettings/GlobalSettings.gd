extends Node

var sprite_scale: float = 1.0

var puntos_max = 5
var current_level: int = 1
var ambient_sound_enabled: bool = false
var current_theme: int = 0 # 0: Clasico, 1: Espacio, 2: Playa, 3: Futbol, 4: Pacman
var is_multiplayer: bool = false

const THEME_NAMES = ["CLASICO", "ESPACIO", "PLAYA", "FUTBOL", "PACMAN"]

func get_background_path() -> String:
	match current_theme:
		1: return "res://assets/background_space.jpg"
		2: return "res://assets/background_beach.jpg"
		_: return "res://assets/background.jpg"

func get_ball_path() -> String:
	match current_theme:
		1: return "res://assets/ball_planet.jpg"
		2: return "res://assets/ball_beach.png"
		_: return "res://assets/ball.png"

# Velocidades Base
const BALL_BASE_SPEED := 500.0
const CPU_BASE_SPEED  := 400.0

func get_ball_speed() -> float:
	# Aumenta 50 unidades de velocidad por nivel (10%)
	return BALL_BASE_SPEED + ((current_level - 1) * 60.0)

func get_cpu_speed() -> float:
	# El CPU también mejora, pero ligeramente menos para ser ganable
	return CPU_BASE_SPEED + ((current_level - 1) * 45.0)

var max_level_reached: int = 1
var max_logro: String = "LEYENDA CLASICA"

const SAVE_PATH = "user://settings.save"

func _ready():
	load_data()

func save_data():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		var data = {
			"max_level": max_level_reached,
			"max_logro": max_logro,
			"ambient_sound": ambient_sound_enabled,
			"current_theme": current_theme,
			"is_multiplayer": is_multiplayer,
			"puntos_max": puntos_max,
			"sprite_scale": sprite_scale
		}
		file.store_line(JSON.stringify(data))

func load_data():
	if not FileAccess.file_exists(SAVE_PATH):
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json_string = file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if parse_result == OK:
			var data = json.get_data()
			if data.has("max_level"): max_level_reached = int(data["max_level"])
			if data.has("max_logro"): max_logro = data["max_logro"]
			if data.has("ambient_sound"): ambient_sound_enabled = data["ambient_sound"]
			if data.has("current_theme"): current_theme = int(data["current_theme"])
			if data.has("is_multiplayer"): is_multiplayer = data["is_multiplayer"]
			if data.has("puntos_max"): puntos_max = int(data["puntos_max"])
			if data.has("sprite_scale"): sprite_scale = float(data["sprite_scale"])

func reset_level():
	current_level = 1
