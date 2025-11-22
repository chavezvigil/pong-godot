extends Control

func _ready():
	var my_font = load("res://assets/alarm clock.ttf").duplicate()
	var spin := $VBoxContainer/Puntos/SpinBox
	spin.add_theme_font_override("font", my_font)
	
	var line_edit: LineEdit = spin.get_line_edit()
	line_edit.add_theme_font_override("font", my_font)
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")


func _on_h_slider_value_changed(value: float) -> void:
	GlobalSettings.sprite_scale = value


func _on_spin_box_value_changed(value: float) -> void:
	GlobalSettings.puntos_max = int(value)
