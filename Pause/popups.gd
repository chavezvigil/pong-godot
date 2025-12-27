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
	_evaluar_pausa()
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _on_continuar_pressed() -> void:
		_evaluar_pausa()
		menu.hide()

func _on_ajustar_pressed() -> void:
	_evaluar_pausa()
	get_tree().change_scene_to_file("res://Settings/settings.tscn")
	
func _evaluar_pausa():
	is_paused = !is_paused
	get_tree().paused = is_paused
