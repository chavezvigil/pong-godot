extends Control

func _ready():
	_setControlPuntos()
	_setControlTamanio()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _setControlPuntos():
	var font := load("res://assets/alarm clock.ttf")
	var font_size := 30   # <---- font
	# Referencia al OptionButton
	var ob: OptionButton = $VBoxContainer/Puntos/OptionButton
	ob.select(0)
	# Cambiar fuente del botón
	ob.add_theme_font_override("font", font)
	ob.add_theme_font_size_override("font_size", font_size)
	# Cambiar fuente del popup (la lista desplegable)
	var popup: PopupMenu = ob.get_popup()
	popup.add_theme_font_override("font", font)
	popup.add_theme_font_size_override("font_size", font_size)


func _setControlTamanio():
	var font := load("res://assets/alarm clock.ttf")
	var font_size := 30   # <---- font
	# Referencia al OptionButton
	var ob: OptionButton = $VBoxContainer/TamanioBall/SetTamanio
	ob.select(1)
	# Cambiar fuente del botón
	ob.add_theme_font_override("font", font)
	ob.add_theme_font_size_override("font_size", font_size)
	# Cambiar fuente del popup (la lista desplegable)
	var popup: PopupMenu = ob.get_popup()
	popup.add_theme_font_override("font", font)
	popup.add_theme_font_size_override("font_size", font_size)

func _on_option_button_item_selected(index: int) -> void:
	if (index == 0):
		GlobalSettings.puntos_max = 5
	elif (index == 1):
		GlobalSettings.puntos_max = 10
	elif (index == 2):
		GlobalSettings.puntos_max = 15
	elif (index == 3):
		GlobalSettings.puntos_max = 20


func _on_set_tamanio_item_selected(index: int) -> void:
	if (index == 0):
		GlobalSettings.sprite_scale = 2
	elif (index == 1):
		GlobalSettings.sprite_scale = 1
	elif (index == 2):
		GlobalSettings.sprite_scale = 0.5
	
