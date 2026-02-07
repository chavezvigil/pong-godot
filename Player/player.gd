extends CharacterBody2D

var speed := 900.0
var dragging := false
var last_y: float
var target_y: float

const TOP_LIMIT := 40.0
const BOTTOM_MARGIN := 40.0

# 🎯 Ajustables
const TOUCH_WIDTH := 80.0     # margen horizontal
const TOUCH_EXTRA_HEIGHT := 40.0
const SMOOTHNESS := 0.25      # 0.15–0.35 recomendado

@onready var viewport_height := get_viewport_rect().size.y
@onready var shape := $CollisionShape2D.shape as CapsuleShape2D
@onready var bar_height := shape.height + shape.radius * 2


func _ready():
	target_y = global_position.y


func _physics_process(delta):
	# 🎮 Teclado (actualiza target)
	if Input.is_action_pressed("ui_up"):
		target_y -= speed * delta
	elif Input.is_action_pressed("ui_down"):
		target_y += speed * delta

	# 🔒 Clamp del objetivo
	target_y = _clamp_y(target_y)

	# ✨ Movimiento suave
	global_position.y = lerp(global_position.y, target_y, SMOOTHNESS)


func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed and _touch_near_paddle(event.position):
			dragging = true
			last_y = event.position.y
			target_y = global_position.y
		else:
			dragging = false

	elif event is InputEventScreenDrag and dragging:
		var delta_y: float = event.position.y - last_y
		last_y = event.position.y

		target_y += delta_y
		target_y = _clamp_y(target_y)


# =====================
# UTILIDADES
# =====================
func _clamp_y(value: float) -> float:
	var half_h := bar_height / 2
	return clamp(
		value,
		TOP_LIMIT + half_h,
		viewport_height - BOTTOM_MARGIN - half_h
	)


func _touch_near_paddle(touch_pos: Vector2) -> bool:
	var half_h := bar_height / 2 + TOUCH_EXTRA_HEIGHT
	var half_w := TOUCH_WIDTH

	var rect := Rect2(
		Vector2(global_position.x - half_w, global_position.y - half_h),
		Vector2(half_w * 2, half_h * 2)
	)

	return rect.has_point(touch_pos)
