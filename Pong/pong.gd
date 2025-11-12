extends Node2D

var CENTER = Vector2(640, 360)
var player_score = 0
var computer_score = 0

func _on_goal_left_body_entered(body: Node2D) -> void:
	computer_score += 1
	$ComputerScore.text = str(computer_score)
	reset ()


func _on_goal_right_body_entered(body: Node2D) -> void:
	player_score += 1
	$PlayerScore.text = str(player_score)
	reset ()
	
func reset () :
	$Ball.position = CENTER
	$Ball.call("set_ball_velocity")
	$Player.position.y = CENTER.y
	$Computer.position.y = CENTER.y
