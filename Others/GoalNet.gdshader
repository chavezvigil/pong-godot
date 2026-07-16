shader_type canvas_item;

uniform vec4 net_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float thickness : hint_range(0.01, 0.5) = 0.1;
uniform float spacing : hint_range(1.0, 20.0) = 8.0;

void fragment() {
    vec2 grid = fract(UV * spacing);
    float line = step(1.0 - thickness, grid.x) + step(1.0 - thickness, grid.y);
    
    // Solo mostrar malla
    COLOR = net_color;
    COLOR.a *= clamp(line, 0.0, 1.0) * 0.4; // Semi-transparente
}
