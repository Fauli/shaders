vec3 palette( float t ) {
    vec3 a = vec3(-0.272, 0.408, 0.480);
    vec3 b = vec3(1.33, 0.56, 0.934);
    vec3 c = vec3(0.431, 0.409, 0.760);
    vec3 d = vec3(1.927, 2.467, 2.667);

    return a + b*cos( 6.28318*(c*t+d) );
}

void main() {
    vec2 uv = (gl_FragCoord.xy * 2.0 - iResolution.xy) / iResolution.y;
    vec2 uv0 = uv;

    // make it in squares
    // uv = fract(uv * 2.0) - 0.5;

    for (int i = 1; i < 8; i++) {
        float power = float(i) * 2.0;
        uv.x += 0.1 / power * sin(power * uv.y + iTime);
        uv.y += 0.1 / power * cos(power * uv.x + iTime);
    }

    
    float r = sin(length(uv) + iTime * 0.10);
    r = fract(r * 10.0);

    uv *= r;

    // make the squares wiggle
    uv += sin(uv * 10.0 + iTime * 0.5) * 0.1;

    // make the straight lines that make up the grid move
    // uv += sin(uv.yx * 10.0 + iTime * 0.5) * 0.1;

    // add more random noise to the color
    // uv += sin(uv.yx * 100.0 + iTime * 0.5) * 0.01;

    // rotate the grid created by the fract
    uv = mat2(cos(iTime * 0.1), -sin(iTime * 0.1), sin(iTime * 0.1), cos(iTime * 0.1)) * uv;

    vec3 color = palette(length(uv) + 0.4 + iTime * .4);

    color *= 1.0 - length(uv) * 15.; 
    
    float a = atan(uv.y, uv.x);
    color += sin(a * 10.0 + iTime * 0.5) * 0.5 + 0.5;

    vec4 col = vec4(vec3(color), 1.0);

    col *= 1.0 - length(uv0) * 0.6;

    

    gl_FragColor = col;
}