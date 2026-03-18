extends Control

# ── Puntos ───────────────────────────────────────────────────
const PUNTOS_OPCIONES := [1, 5, 10, 15]
var puntos_idx := 1   # default: 5

# ── Tamaño balón ─────────────────────────────────────────────
const TAMANIO_NOMBRES  := ["GRANDE", "NORMAL", "PEQUENIO"]
const TAMANIO_ESCALAS  := [2.0, 1.0, 0.5]
var tamanio_idx := 1  # default: NORMAL

# ── Temática ─────────────────────────────────────────────────
var tematica_idx := 0

# ── Nodos ────────────────────────────────────────────────────
@onready var lbl_puntos:   Label = $Panel/VBox/RowPuntos/LblPuntosVal
@onready var lbl_tamanio:  Label = $Panel/VBox/RowTamanio/LblTamanioVal
@onready var lbl_tematica: Label = $Panel/VBox/RowTematica/LblTematicaVal
@onready var lbl_sonido:   Label = $Panel/VBox/RowSonido/LblSonidoVal
@onready var panel: PanelContainer = $Panel

func _ready() -> void:
	# Sync con GlobalSettings si ya fue cambiado
	var pi := PUNTOS_OPCIONES.find(GlobalSettings.puntos_max)
	if pi >= 0: puntos_idx = pi
	var ti := TAMANIO_ESCALAS.find(GlobalSettings.sprite_scale)
	if ti >= 0: tamanio_idx = ti
	tematica_idx = GlobalSettings.current_theme

	_refresh_labels()
	_animate_entry()

func _refresh_labels() -> void:
	lbl_puntos.text   = str(PUNTOS_OPCIONES[puntos_idx])
	lbl_tamanio.text  = TAMANIO_NOMBRES[tamanio_idx]
	lbl_tematica.text = GlobalSettings.THEME_NAMES[tematica_idx]
	lbl_sonido.text   = "SI" if GlobalSettings.ambient_sound_enabled else "NO"

func _animate_entry() -> void:
	panel.modulate.a = 0.0
	panel.position.y += 40
	var tw := create_tween().set_parallel(true)
	tw.tween_property(panel, "modulate:a", 1.0, 0.35)
	tw.tween_property(panel, "position:y", panel.position.y - 40, 0.35)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

# ── Puntos ◀ ▶ ───────────────────────────────────────────────
func _on_btn_puntos_left_pressed() -> void:
	puntos_idx = (puntos_idx - 1 + PUNTOS_OPCIONES.size()) % PUNTOS_OPCIONES.size()
	GlobalSettings.puntos_max = PUNTOS_OPCIONES[puntos_idx]
	_flash_label(lbl_puntos)
	_refresh_labels()

func _on_btn_puntos_right_pressed() -> void:
	puntos_idx = (puntos_idx + 1) % PUNTOS_OPCIONES.size()
	GlobalSettings.puntos_max = PUNTOS_OPCIONES[puntos_idx]
	_flash_label(lbl_puntos)
	_refresh_labels()

# ── Tamaño ◀ ▶ ───────────────────────────────────────────────
func _on_btn_tamanio_left_pressed() -> void:
	tamanio_idx = (tamanio_idx - 1 + TAMANIO_ESCALAS.size()) % TAMANIO_ESCALAS.size()
	GlobalSettings.sprite_scale = TAMANIO_ESCALAS[tamanio_idx]
	_flash_label(lbl_tamanio)
	_refresh_labels()

func _on_btn_tamanio_right_pressed() -> void:
	tamanio_idx = (tamanio_idx + 1) % TAMANIO_ESCALAS.size()
	GlobalSettings.sprite_scale = TAMANIO_ESCALAS[tamanio_idx]
	_flash_label(lbl_tamanio)
	_refresh_labels()

# ── Temática ◀ ▶ ─────────────────────────────────────────────
func _on_btn_tematica_left_pressed() -> void:
	tematica_idx = (tematica_idx - 1 + GlobalSettings.THEME_NAMES.size()) % GlobalSettings.THEME_NAMES.size()
	GlobalSettings.current_theme = tematica_idx
	_flash_label(lbl_tematica)
	_refresh_labels()

func _on_btn_tematica_right_pressed() -> void:
	tematica_idx = (tematica_idx + 1) % GlobalSettings.THEME_NAMES.size()
	GlobalSettings.current_theme = tematica_idx
	_flash_label(lbl_tematica)
	_refresh_labels()

func _on_btn_sonido_toggle_pressed() -> void:
	GlobalSettings.ambient_sound_enabled = !GlobalSettings.ambient_sound_enabled
	_flash_label(lbl_sonido)
	_refresh_labels()

# Animación rápida al cambiar valor
func _flash_label(lbl: Label) -> void:
	var tw := create_tween().set_parallel(true)
	tw.tween_property(lbl, "scale", Vector2(1.25, 1.25), 0.08)
	tw.tween_property(lbl, "modulate", Color(0.4, 0.9, 1.0), 0.08)
	await tw.finished
	var tw2 := create_tween().set_parallel(true)
	tw2.tween_property(lbl, "scale", Vector2(1.0, 1.0), 0.12).set_ease(Tween.EASE_OUT)
	tw2.tween_property(lbl, "modulate", Color(1, 1, 1), 0.12)

# ── Regresar ─────────────────────────────────────────────────
func _on_btn_back_pressed() -> void:
	GlobalSettings.save_data()
	var tw := create_tween()
	tw.tween_property(self, "modulate:a", 0.0, 0.2)
	tw.tween_callback(func(): get_tree().change_scene_to_file("res://Menu/menu.tscn"))
