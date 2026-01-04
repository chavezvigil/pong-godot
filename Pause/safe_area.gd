extends MarginContainer

func _ready():
	if OS.has_feature("android"):
		var safe := DisplayServer.get_display_safe_area()
		add_theme_constant_override("margin_left", safe.position.x)
		add_theme_constant_override("margin_top", safe.position.y)
		add_theme_constant_override(
			"margin_right",
			get_viewport_rect().size.x - safe.size.x - safe.position.x
		)
		add_theme_constant_override(
			"margin_bottom",
			get_viewport_rect().size.y - safe.size.y - safe.position.y
		)
