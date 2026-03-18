extends CharacterBody2D

# Velocidad dinámica basada en nivel
@onready var speed = GlobalSettings.get_ball_speed()
var particles: CPUParticles2D

func _ready(): 
	# Aplicar textura segun tema
	var tex = load(GlobalSettings.get_ball_path())
	if tex:
		$Sprite2D.texture = tex
		# Ajustar escala para que el balon tenga un tamaño consistente (~64x64)
		var target_ball_size = Vector2(64, 64)
		$Sprite2D.scale = target_ball_size / tex.get_size()
		
		# Aplicar shader para hacerlo redondo con bordes suaves (anti-aliasing)
		var mat = ShaderMaterial.new()
		var sh = Shader.new()
		sh.code = "shader_type canvas_item;
			uniform float is_soccer = 0.0;
			uniform float is_pacman = 0.0;
			void fragment() {
				float dist = distance(UV, vec2(0.5, 0.5));
				vec4 tex = texture(TEXTURE, UV);
				
				// Pattern de Futbol (Hexagonos/Pentagonos procedurales)
				if (is_soccer > 0.5) {
					vec2 p = (UV - 0.5) * 10.0;
					float pattern = step(0.65, sin(p.x) * cos(p.y) + sin(p.y*0.8) * cos(p.x*1.2));
					tex = mix(vec4(1,1,1,1), vec4(0.1, 0.1, 0.1, 1), pattern);
				}
				
				// Pacman: Amarillo con boca animada
				if (is_pacman > 0.5) {
					vec2 rel = UV - 0.5;
					float angle = atan(rel.y, rel.x);
					float mouth_open = abs(sin(TIME * 10.0)) * 0.8;
					if (abs(angle) < mouth_open) {
						tex.a = 0.0;
					} else {
						tex = vec4(1.0, 1.0, 0.0, 1.0);
					}
				}
				
				float mask = 1.0 - smoothstep(0.48, 0.5, dist);
				COLOR = vec4(tex.rgb, tex.a * mask);
			}"
		mat.shader = sh
		if GlobalSettings.current_theme == 3:
			mat.set_shader_parameter("is_soccer", 1.0)
		if GlobalSettings.current_theme == 4:
			mat.set_shader_parameter("is_pacman", 1.0)
		$Sprite2D.material = mat

	_setup_trail()
	_setup_particles()
	set_ball_velocity()

var trail_points = []
var trail_node : Line2D

func _setup_trail():
	trail_node = Line2D.new()
	trail_node.width = 40.0
	trail_node.width_curve = Curve.new()
	trail_node.width_curve.add_point(Vector2(0, 1))
	trail_node.width_curve.add_point(Vector2(1, 0))
	trail_node.default_color = Color(1, 1, 1, 0.4)
	trail_node.top_level = true # Para que no se mueva con la bola
	trail_node.z_index = -1 # Detras de la bola
	add_child(trail_node)
	
func _setup_particles():
	particles = CPUParticles2D.new()
	particles.amount = 12
	particles.explosiveness = 1.0
	particles.lifetime = 0.4
	particles.spread = 180.0
	particles.gravity = Vector2.ZERO
	particles.initial_velocity_min = 100.0
	particles.initial_velocity_max = 200.0
	particles.scale_amount_min = 2.0
	particles.scale_amount_max = 4.0
	particles.emitting = false
	particles.one_shot = true
	add_child(particles)

func _spawn_particles():
	# Color segun tema
	match GlobalSettings.current_theme:
		1: particles.color = Color(0.4, 0.9, 1.0) # Espacio: Cian
		2: particles.color = Color(1.0, 0.9, 0.6) # Playa: Oro
		3: particles.color = Color(0.1, 0.6, 0.2) # Futbol: Verde
		4: particles.color = Color(1.0, 1.0, 0.0) # Pacman: Amarillo
		_: particles.color = Color(1, 1, 1)      # Clasico: Blanco
	
	particles.restart()
	particles.emitting = true

func set_ball_velocity(): 
	if randi() % 2 == 0:
		velocity.x = 1
	else:
		velocity.x = -1
		
	if randi() % 2 == 0:
		velocity.y = 1
	else:
		velocity.y = -1
		
	speed = GlobalSettings.get_ball_speed()
	velocity *= speed

func _physics_process(delta):
	var collition_info = move_and_collide(velocity * delta)
	if collition_info:
		velocity = velocity.bounce(collition_info.get_normal())
		# Reproducir sonido de impacto solo contra jugadores
		var collider = collition_info.get_collider()
		if collider.name == "Player" or collider.name == "Computer":
			# Haptics: Vibrar al chocar
			Input.vibrate_handheld(20)
			_spawn_particles()
			
			var audio = get_parent().get_node_or_null("AmbientAudio")
			if audio:
				audio.play_hit_sound()
	
func _process(delta):
	# Estela (Trail)
	if trail_node:
		trail_points.push_front(global_position)
		if trail_points.size() > 15:
			trail_points.pop_back()
		trail_node.points = trail_points
		# Sincronizar color con el tema (opcionalmente)
		if GlobalSettings.current_theme == 1: # Espacio
			trail_node.default_color = Color(0.4, 0.7, 1.0, 0.4)
		elif GlobalSettings.current_theme == 2: # Playa
			trail_node.default_color = Color(1.0, 0.9, 0.6, 0.4)
		else:
			trail_node.default_color = Color(1, 1, 1, 0.4)

	# Rotación Premium
	$Sprite2D.rotation += velocity.length() * 0.005 * delta
	scale = Vector2(GlobalSettings.sprite_scale, GlobalSettings.sprite_scale)
