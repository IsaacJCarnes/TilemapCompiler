shader_type canvas_item;
uniform vec4 second_color : source_color;
uniform vec4 main_color : source_color;
void fragment() {
	if(COLOR.a != 0.0){
		COLOR = vec4(second_color.x,second_color.y,second_color.z,COLOR.a);
	}//mix(COLOR, , .5);
}