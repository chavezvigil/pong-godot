extends CanvasLayer

@onready var menu = $Menu
var is_paused = false


func _ready():
	menu.hide()

func show_menu():
	is_paused = !is_paused
		
	if is_paused == true:
		menu.show()
		get_tree().paused = is_paused
	else: 
		menu.hide()
		get_tree().paused = is_paused
		
func _on_button_pressed() -> void:
	is_paused = !is_paused
	get_tree().paused = is_paused
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
