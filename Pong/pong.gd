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

func _ready() -> void:
	player_score = GlobalSettings.puntos_max
	computer_score = GlobalSettings.puntos_max
	computerScore.text = str(computer_score)
	playerScore.text = str(player_score)
	
	pause_menu = pause_scene.instantiate()
	add_child(pause_menu)
	
	reset_menu = reset_scene.instantiate()
	add_child(reset_menu)
	
	

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
			resultado = "GANASTE!!! XD"
		else:
			resultado = "PERDISTE!!! :("	
		
		player_score = GlobalSettings.puntos_max
		computer_score = GlobalSettings.puntos_max
		computerScore.text = str(computer_score)
		playerScore.text = str(player_score)
		
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
	
