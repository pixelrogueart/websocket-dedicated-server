shader_type canvas_item;

uniform float hit_opacity = 0;

void fragment(){
 COLOR.rgb = texture(TEXTURE, UV).rgb * (1.0 - hit_opacity) + vec3(1,1,1) * hit_opacity;
 COLOR.a = texture(TEXTURE, UV).a ;
}