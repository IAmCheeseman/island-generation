shader_type spatial;
//render_mode unshaded;
const float d45 = PI / 4.0;

uniform vec4 grassColor : hint_color;
uniform vec4 stoneColor : hint_color;
uniform vec4 snowColor : hint_color;
uniform vec4 sandColor : hint_color;
uniform sampler2D noise;
uniform float height = 1;
uniform float flatness = 1;
uniform float snowHeight = .7;
uniform float stoneHeight = 1.4;

varying float vh;
varying float normal;

void vertex()
{
	float h = texture(noise, vec2(VERTEX.x, VERTEX.z)).r;
	h *= height;
	h *= 1.0 - sin(PI * (abs(VERTEX.x) / 2.0));
	h *= 1.0 - sin(PI * (abs(VERTEX.z) / 2.0));
	h *= flatness;
	VERTEX.y += h;
	
	vh = VERTEX.y;
	normal = dot(NORMAL, vec3(0.0, 1.0, 0.0));
}

void fragment()
{
	float r = texture(noise, UV).r;
	if (vh > snowHeight - (r * .5)) {
		ALBEDO = snowColor.rgb;
	} else if (r < vh * stoneHeight) {
		ALBEDO = stoneColor.rgb;
	} else if (vh > 0.16) {
		ALBEDO = grassColor.rgb;
	} else {
		ALBEDO = sandColor.rgb;
	}
}
