extends Node2D

var CENTER = Vector2(640, 360)
var player_score = 20
var computer_score = 20
var is_paused = false

func _ready() -> void:
	$ComputerScore.text = str(computer_score)
	$PlayerScore.text = str(player_score)
	

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
		player_score = 20
		computer_score = 20
		$ComputerScore.text = str(computer_score)
		$PlayerScore.text = str(player_score)	


func _on_touch_screen_button_pressed() -> void:
	is_paused = !is_paused
	get_tree().paused = is_paused
