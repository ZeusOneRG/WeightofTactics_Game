shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float outline_intensity : hint_range(0.0, 5.0) = 2.0;

// Primero declaramos la función auxiliar para que Godot sepa que existe
float total_difference(vec4 c1, vec4 c2) {
    return (abs(c1.r - c2.r) + abs(c1.g - c2.g) + abs(c1.b - c2.b)) / 3.0;
}

void fragment() {
    // 1. Conseguimos el color original y le aplicamos la modulación del script (el naranja)
    vec4 original_color = texture(TEXTURE, UV) * COLOR;
    
    // 2. Tomamos muestras de los píxeles de los costados para medir el contraste (bordes)
    vec2 size = TEXTURE_PIXEL_SIZE;
    
    vec4 top = texture(TEXTURE, UV + vec2(0.0, -size.y));
    vec4 bottom = texture(TEXTURE, UV + vec2(0.0, size.y));
    vec4 left = texture(TEXTURE, UV + vec2(-size.x, 0.0));
    vec4 right = texture(TEXTURE, UV + vec2(size.x, 0.0));
    
    // 3. Calculamos qué tan brusco es el cambio de color en los bordes del metal
    float edge = total_difference(original_color, top) +
                 total_difference(original_color, bottom) +
                 total_difference(original_color, left) +
                 total_difference(original_color, right);
                 
    edge = clamp(edge * outline_intensity, 0.0, 1.0);
    
    // 4. Mezclamos el botón original con el contorno negro en las zonas de relieve
    vec3 final_rgb = mix(original_color.rgb, outline_color.rgb, edge * outline_color.a);
    
    COLOR = vec4(final_rgb, original_color.a);
}
