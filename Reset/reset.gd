extends CanvasLayer

@onready var reset = $Reset
var is_paused = false

@onready var msg_label: Label = $Reset/SafeArea/VBoxContainer/Msg

func _ready():
	reset.hide()
	process_mode = Node.PROCESS_MODE_ALWAYS

func show_menu():
	reset.show()
	get_tree().paused = true
	
func hide_menu():
	reset.hide()
	get_tree().paused = false

func set_msg (msg) :
	var font := load("res://assets/alarm clock.ttf")
	var font_size := 60   # <---- font
	msg_label.add_theme_font_override("font", font)
	msg_label.add_theme_font_size_override("font_size", font_size)
	msg_label.text = str(msg)
	
func _on_salir_reset_pressed() -> void:
	hide_menu()
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _on_seguir_pressed() -> void:
	hide_menu()
	get_tree().change_scene_to_file("res://Pong/pong.tscn")
