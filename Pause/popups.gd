extends CanvasLayer

@onready var panel: PanelContainer = $Panel
@onready var overlay: ColorRect = $Overlay
var is_paused = false

func _ready():
	_hide_all()
	process_mode = Node.PROCESS_MODE_ALWAYS

func _hide_all():
	panel.hide()
	overlay.hide()
	get_tree().paused = false
	is_paused = false

func show_menu():
	is_paused = !is_paused
	get_tree().paused = is_paused
	
	if is_paused:
		overlay.show()
		panel.show()
		# Animación de entrada
		panel.scale = Vector2(0.85, 0.85)
		panel.modulate.a = 0.0
		var tw := create_tween().set_parallel(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		tw.tween_property(panel, "scale", Vector2.ONE, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
		tw.tween_property(panel, "modulate:a", 1.0, 0.2)
	else:
		_hide_all()

func _on_button_pressed() -> void:
	_hide_all()
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

func _on_continuar_pressed() -> void:
	_hide_all()

func _on_ajustar_pressed() -> void:
	# Antes de ir a ajustes, asegurar que despausamos o manejamos el estado
	_hide_all()
	get_tree().change_scene_to_file("res://Settings/settings.tscn")
