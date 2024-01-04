// 2D rotation function
mat2 rot(float a) {
	return mat2(cos(a),sin(a),-sin(a),cos(a));	
}


// "Amazing Surface" fractal
vec4 formula(vec4 p) {
		p.xz = abs(p.xz+1.)-abs(p.xz-1.)-p.xz;
		p.y-=.25;
		p.xy*=rot(radians(35.));
		p=p*2./clamp(dot(p.xyz,p.xyz),.2,1.);
	return p;
}



void main() {
    vec2 uv = (gl_FragCoord.xy * 2.0 - iResolution.xy) / iResolution.y;
    vec2 m = (iMouse.xy * 2. - iResolution.xy) / iResolution.y;
    vec2 uv0 = uv;

    float r = sin(length(uv) - iTime * sin(iTime * 0.00001 + 0.1));
    r = fract(r * 20.0);

    // uv *= r;

    vec3 col = vec3(uv0.x, uv0.y, r);

    gl_FragColor = vec4(col, 1.0);
    }