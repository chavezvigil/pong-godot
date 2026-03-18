extends AudioStreamPlayer

var playback: AudioStreamGeneratorPlayback
var sample_hz: float = 44100.0
var phase: float = 0.0

# --- Sistema de SFX Procedural ---
var sfx_phase: float = 0.0
var sfx_duration: float = 0.0 # Segundos restantes
var sfx_freq: float = 800.0

func _ready():
	var generator = AudioStreamGenerator.new()
	generator.mix_rate = sample_hz
	generator.buffer_length = 0.05 # Latencia mínima
	stream = generator
	
	play()
	playback = get_stream_playback()
	process_mode = Node.PROCESS_MODE_ALWAYS

func play_hit_sound():
	sfx_freq = 650.0 + randf() * 150.0 # Tono tennis
	sfx_duration = 0.12
	sfx_phase = 0.0

func _process(delta):
	if not playing or playback == null:
		return
	
	if get_tree().paused:
		var to_fill = playback.get_frames_available()
		while to_fill > 0:
			playback.push_frame(Vector2.ZERO)
			to_fill -= 1
		return

	if sfx_duration > 0:
		sfx_duration -= delta

	_fill_buffer()

func _fill_buffer():
	var to_fill = playback.get_frames_available()
	while to_fill > 0:
		var ambient_v = 0.0
		
		# --- AMBIENT GEN ---
		if GlobalSettings.ambient_sound_enabled:
			match GlobalSettings.current_theme:
				1: # ESPACIO
					var freq = 45.0 + sin(phase * 0.2) * 2.0 
					var shimmer = sin(phase * TAU * 880.0 / sample_hz) * 0.02 * (sin(phase * 0.0002) + 1.0)
					ambient_v = (sin(phase * TAU * freq / sample_hz) * 0.06) + shimmer
					
				2: # PLAYA
					var noise = randf() * 2.0 - 1.0
					var waves = noise * (sin(phase * 0.00005) + 1.0) * 0.5 * 0.08
					var wind = noise * (sin(phase * 0.00002) + 1.0) * 0.5 * 0.03
					ambient_v = waves + wind
					
				3: # FUTBOL
					var noise = randf() * 2.0 - 1.0
					var crowd = 0.04 + (abs(sin(phase * 0.0001)) * 0.03) 
					ambient_v = noise * crowd
					
				4: # PACMAN
					var freq = 150.0 + (int(phase * 0.002) % 4) * 50.0
					ambient_v = 0.05 if sin(phase * TAU * freq / sample_hz) > 0 else -0.05
					
				_: # CLASICO
					var breathing = (sin(phase * TAU * 0.2 / sample_hz) + 1.0) * 0.5 
					ambient_v = sin(phase * TAU * 432.0 / sample_hz) * 0.04 * breathing
		
		phase += 1.0

		# --- SFX GEN (Tennis Hit) ---
		var sfx_v = 0.0
		if sfx_duration > 0:
			var envelope = sfx_duration / 0.12
			sfx_v = sin(sfx_phase * TAU * sfx_freq / sample_hz) * 0.25 * envelope
			sfx_phase += 1.0
		
		# Mezcla Final
		var final_v = ambient_v + sfx_v
		playback.push_frame(Vector2(final_v, final_v))
		to_fill -= 1

	if phase > 1000000: phase = 0
