shader_type spatial;
render_mode cull_disabled;

uniform float foam_level = 0.2f;
uniform float roughness_value = 0.7;

uniform vec4 colorDeep : hint_color;
uniform vec4 colorShallow : hint_color;

varying float vertex_height;

uniform float wave_speed = 0.5; 
uniform vec4 wave_a = vec4(1.0, 1.0, 0.35, 3.0);
uniform vec4 wave_b = vec4(1.0, 0.6, 0.30, 1.55);
uniform vec4 wave_c = vec4(1.0, 1.3, 0.25, 0.9);

uniform vec2 sampler_scale 	= vec2(0.25, 0.25);

uniform float beers_law = 2.0;
uniform float up_depth_offset = -0.75;
uniform float down_depth_offset = -0.75;

varying vec3 vertex_normal;
varying vec3 vertex_binormal;
varying vec3 vertex_tangent;

varying mat4 inv_mvp;


vec4 wave(vec4 parameter, vec2 position, float time,  vec3 tangent, vec3 binormal)
{
	float wave_steepness = parameter.z;
	float wave_length = parameter.w;

	float k = 2.0 * 3.14159265359 / wave_length;
	float c = sqrt(9.8 / k);
	vec2 d = normalize(parameter.xy);
	float f = k * (dot(d, position) - c * time);
	float a = wave_steepness / k;
	
	tangent += normalize(vec3(1.0-d.x * d.x * (wave_steepness * sin(f)), d.x * (wave_steepness * cos(f)), -d.x * d.y * (wave_steepness * sin(f))));
	binormal += normalize(vec3(-d.x * d.y * (wave_steepness * sin(f)), d.y * (wave_steepness * cos(f)), 1.0-d.y * d.y * (wave_steepness * sin(f))));

	return vec4(d.x * (a * cos(f)), a * sin(f) * 0.25, d.y * (a * cos(f)), 0.0);
}

void vertex()
{
	float time = TIME * wave_speed;
	
	vec4 vertex = vec4(VERTEX, 1.0);
	vec3 vertex_position  = (WORLD_MATRIX * vertex).xyz;
	
	vertex_tangent = vec3(0.0, 0.0, 0.0);
	vertex_binormal = vec3(0.0, 0.0, 0.0);
	
	vertex += wave(wave_a, vertex_position.xz, time, vertex_tangent, vertex_binormal);
	vertex += wave(wave_b, vertex_position.xz, time, vertex_tangent, vertex_binormal);
	vertex += wave(wave_c, vertex_position.xz, time, vertex_tangent, vertex_binormal);
	
	vertex_position  = vertex.xyz;
	
	vertex_height = (PROJECTION_MATRIX * MODELVIEW_MATRIX * vertex).z;
	
	TANGENT = vertex_tangent;
	BINORMAL = vertex_binormal;
	vertex_normal = normalize(cross(vertex_binormal, vertex_tangent));
	NORMAL = vertex_normal;
	
	UV = vertex.xz * sampler_scale;
	
	VERTEX = vertex.xyz;
	
	inv_mvp = inverse(PROJECTION_MATRIX * MODELVIEW_MATRIX);
}

void fragment()
{
	vec4 world_normal = vec4(NORMAL, 1.0) * INV_CAMERA_MATRIX;

	float depth_raw = texture(DEPTH_TEXTURE, SCREEN_UV).r * 2.0 - 1.0;
	float depth = PROJECTION_MATRIX[3][2] / (depth_raw + PROJECTION_MATRIX[2][2]);
	
	float depth_blend  = exp((depth+VERTEX.z + mix(up_depth_offset, down_depth_offset, world_normal.y)) * -beers_law);
	depth_blend = clamp(1.0-depth_blend, 0.0, 1.0);
	float depth_blend_pow = clamp(pow(depth_blend, 2.5), 0.0, 1.0);
	
	vec3 screenColor = textureLod(SCREEN_TEXTURE, SCREEN_UV + (NORMAL.xz * 0.02), depth_blend_pow * 2.5).rgb;
	vec3 dyeColor = mix(colorShallow.rgb, colorDeep.rgb, depth_blend_pow);
	vec3 color = mix(screenColor*dyeColor, dyeColor*0.25, depth_blend_pow*0.5);
	
	float foamAmount = max(min(1.0, (foam_level - depth - VERTEX.z) / foam_level), 0.0);
	
	ALBEDO = mix(color, vec3(1.0, 1.0, 1.0), foamAmount);
	SPECULAR = mix(0.2 * depth_blend_pow * 0.4, 0.1, foamAmount);
	ROUGHNESS = roughness_value;
}