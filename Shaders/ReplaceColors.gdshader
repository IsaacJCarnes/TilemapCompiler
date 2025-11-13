shader_type canvas_item;
uniform vec4 main_color : source_color;
uniform vec4 second_color : source_color;
void fragment() {
	if(COLOR.a != 0.0){
		if(COLOR.x > 0.1){
			COLOR = vec4(second_color.x,second_color.y,second_color.z,COLOR.a);
		} else {
			COLOR = vec4(main_color.x,main_color.y,main_color.z,COLOR.a);
		}
	}//mix(COLOR, , .5);
}