extends Node2D

var CENTER = Vector2(640, 360)
var player_score = 0
var computer_score = 0

@onready var pause_scene = preload("res://Pause/popups.tscn")
var pause_menu

func _ready() -> void:
	player_score = GlobalSettings.puntos_max
	computer_score = GlobalSettings.puntos_max
	$ComputerScore.text = str(computer_score)
	$PlayerScore.text = str(player_score)
	pause_menu = pause_scene.instantiate()
	add_child(pause_menu)

func _on_goal_left_body_entered(body: Node2D) -> void:
	player_score -= 1
	$PlayerScore.text = str(player_score)
	set_game ()
	reset ()


func _on_goal_right_body_entered(body: Node2D) -> void:
	computer_score -= 1
	$ComputerScore.text = str(computer_score)
	set_game ()
	reset ()
	
func reset () :
	$Ball.position = CENTER
	$Ball.call("set_ball_velocity")
	$Player.position.y = CENTER.y
	$Computer.position.y = CENTER.y
	
func set_game () :
	if (player_score == 0) or (computer_score == 0) :
		player_score = GlobalSettings.puntos_max
		computer_score = GlobalSettings.puntos_max
		$ComputerScore.text = str(computer_score)
		$PlayerScore.text = str(player_score)	
		
func _on_touch_screen_button_pressed() -> void:
	pause_menu.show_menu()
	
	
