extends Control


func _on_quit_pressed() -> void:
	get_tree().quit(0)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Pong/pong.tscn")

func _on_set_pressed() -> void:
	get_tree().change_scene_to_file("res://Settings/settings.tscn")
