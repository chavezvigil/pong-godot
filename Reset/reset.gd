extends CanvasLayer

@onready var panel: PanelContainer = $Panel
@onready var msg_label: Label = $Panel/VBox/Msg
@onready var overlay: ColorRect = $Overlay

func _ready():
	hide_nodes()
	process_mode = Node.PROCESS_MODE_ALWAYS

func hide_nodes():
	panel.hide()
	overlay.hide()
	get_tree().paused = false

func show_menu():
	overlay.show()
	panel.show()
	get_tree().paused = true
	
	# Animación de entrada
	panel.scale = Vector2(0.85, 0.85)
	panel.modulate.a = 0.0
	var tw := create_tween().set_parallel(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tw.tween_property(panel, "scale", Vector2.ONE, 0.35).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tw.tween_property(panel, "modulate:a", 1.0, 0.25)

func set_msg(msg: String) :
	msg_label.text = msg

func _on_salir_reset_pressed() -> void:
	hide_nodes()
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _on_seguir_pressed() -> void:
	hide_nodes()
	get_tree().change_scene_to_file("res://Pong/pong.tscn")
