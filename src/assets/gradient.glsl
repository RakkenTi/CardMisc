// Remember, texture_coords is always 0 if not dealing with textures.
extern vec2 rect_pos;
extern vec2 rect_size;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 rect_center = rect_pos + rect_size * 0.5;
    vec2 relative_coords = screen_coords - rect_center;
    float distance = length(relative_coords) / length(rect_size * 0.5);
    float brightness = distance * .1;
    vec3 brightenedColor = color.rgb + brightness * 0.15;
    return vec4(brightenedColor, color.a);
}