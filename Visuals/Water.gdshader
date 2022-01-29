shader_type spatial;
render_mode specular_toon;

uniform vec4 color : hint_color;
uniform sampler2D noise;
uniform float height = .1;
uniform float waveTime = 0.1;
uniform sampler2D normalMap;


void vertex()
{
	float vertexHeight = texture(noise, vec2(VERTEX.x, VERTEX.z)).r;
	vertexHeight *= height;
	vertexHeight *= sin(TIME) * waveTime;
	VERTEX.y += vertexHeight;
}

void fragment()
{
	SPECULAR = 1.0;
	ROUGHNESS = 0.0;
	NORMAL_MAP = texture(normalMap, UV).rgb;
	ALBEDO = color.rgb;
}
