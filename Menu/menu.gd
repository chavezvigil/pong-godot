extends Control

# Pelota decorativa
var ball_pos := Vector2(640, 360)
var ball_vel := Vector2(320, 220)
var ball_radius := 12.0

# Referencias
@onready var deco_ball: ColorRect = $DecoBall
@onready var title_label: Label = $TitleLabel
@onready var btn_play: Button = $ButtonsContainer/BtnPlay
@onready var btn_mode: Button = $ButtonsContainer/BtnMode
@onready var btn_set: Button = $ButtonsContainer/BtnSet
@onready var btn_quit: Button = $ButtonsContainer/BtnQuit

func _ready() -> void:
	_animate_entry()
	_animate_title_pulse()
	$RecordLabel.text = "RECORD: NIVEL " + str(GlobalSettings.max_level_reached)
	if GlobalSettings.max_level_reached > 1:
		$RecordLabel.text += " (" + GlobalSettings.max_logro + ")"
	_update_mode_text()

func _update_mode_text():
	btn_mode.text = "2 JUGADORES" if GlobalSettings.is_multiplayer else "1 JUGADOR"

func _animate_entry() -> void:
	# Posición inicial fuera de pantalla (izquierda)
	var buttons := [btn_play, btn_mode, btn_set, btn_quit]
	for btn in buttons:
# ... (rest of the file update)
		btn.modulate.a = 0.0
		btn.position.x -= 300

	var delay := 0.0
	for btn in buttons:
		var tw := create_tween()
		tw.set_parallel(true)
		tw.tween_property(btn, "modulate:a", 1.0, 0.4).set_delay(delay)
		tw.tween_property(btn, "position:x", btn.position.x + 300, 0.4)\
			.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_delay(delay)
		delay += 0.12

func _animate_title_pulse() -> void:
	var tw := create_tween().set_loops()
	tw.tween_property(title_label, "scale", Vector2(1.04, 1.04), 0.8)\
		.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tw.tween_property(title_label, "scale", Vector2(1.0, 1.0), 0.8)\
		.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

func _process(delta: float) -> void:
	var vp := get_viewport_rect().size
	ball_pos += ball_vel * delta

	if ball_pos.x - ball_radius <= 0:
		ball_vel.x = abs(ball_vel.x)
	elif ball_pos.x + ball_radius >= vp.x:
		ball_vel.x = -abs(ball_vel.x)

	if ball_pos.y - ball_radius <= 0:
		ball_vel.y = abs(ball_vel.y)
	elif ball_pos.y + ball_radius >= vp.y:
		ball_vel.y = -abs(ball_vel.y)

	deco_ball.position = ball_pos - Vector2(ball_radius, ball_radius)

# ── Hover / Touch effects ────────────────────────────────────
func _on_btn_play_button_down()  -> void: _hover_in(btn_play)
func _on_btn_play_button_up()    -> void: _hover_out(btn_play)
func _on_btn_set_button_down()   -> void: _hover_in(btn_set)
func _on_btn_set_button_up()     -> void: _hover_out(btn_set)
func _on_btn_quit_button_down()  -> void: _hover_in(btn_quit)
func _on_btn_quit_button_up()    -> void: _hover_out(btn_quit)

func _hover_in(btn: Button) -> void:
	var tw := create_tween()
	tw.tween_property(btn, "scale", Vector2(1.07, 1.07), 0.12)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

func _hover_out(btn: Button) -> void:
	var tw := create_tween()
	tw.tween_property(btn, "scale", Vector2(1.0, 1.0), 0.12)\
		.set_ease(Tween.EASE_OUT)

func _on_btn_mode_button_down()  -> void: _hover_in(btn_mode)
func _on_btn_mode_button_up()    -> void: _hover_out(btn_mode)

func _on_btn_mode_pressed() -> void:
	GlobalSettings.is_multiplayer = !GlobalSettings.is_multiplayer
	GlobalSettings.save_data()
	_update_mode_text()
	_flash_button(btn_mode)

# Efecto de flash al cambiar modo
func _flash_button(btn: Button) -> void:
	var tw := create_tween()
	tw.tween_property(btn, "scale", Vector2(1.1, 1.1), 0.08)
	tw.tween_property(btn, "scale", Vector2(1.0, 1.0), 0.12)

# ── Navegación ───────────────────────────────────────────────
func _on_btn_play_pressed() -> void:
	GlobalSettings.reset_level()
	_transition_out("res://Pong/pong.tscn")

func _on_btn_set_pressed() -> void:
	_transition_out("res://Settings/settings.tscn")

func _on_btn_quit_pressed() -> void:
	get_tree().quit(0)

func _transition_out(scene: String) -> void:
	var tw := create_tween()
	tw.tween_property(self, "modulate:a", 0.0, 0.25)
	tw.tween_callback(func(): get_tree().change_scene_to_file(scene))
