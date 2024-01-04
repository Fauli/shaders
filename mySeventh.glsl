void main() {
    vec2 uv = (gl_FragCoord.xy * 2.0 - iResolution.xy) / iResolution.y;
    vec2 uv0 = uv;

    // can be commented out :)
    uv = fract(uv * 2.0) - 0.5;
    uv = fract(uv * 2.0) - 0.5;
    uv = fract(uv * 2.0) - 0.5;
    // uv0 = fract(uv0 * 2.0) - 0.5;

    for (int i = 1; i < 8; i++) {
        float power = float(i) * 2.0;
        uv.x += 0.1 / power * sin(power * uv.y + iTime);
        uv.y += 0.1 / power * cos(power * uv.x + iTime);
    }

    // uv *= mat2(cos(iTime)*0.5, -cos(iTime)*.3, sin(iTime), cos(iTime)*1.5);

        for (int i = 1; i < 223; i++) {
        float power = float(i) * 2.0;
        uv0.x += 0.1 / power * sin(power * uv0.y + iTime);
        uv0.y += 0.1 / power * cos(power * uv0.x + iTime);
    }
    
    vec3 col = (uv.y < 0.0) ? vec3(1.0, 0.0, 0.0) : vec3(0.0, 0.9, 0.0);
    // if (uv.x > 0.3 && uv.y < 0.0) {
    //     col = vec3(0.0, 0.0, 1.0);
    // }

    col = mix(col, vec3(0.0, 0.0,0.0), length(uv0));

    col.r = smoothstep(0.2, 0.9, col.r);
    col.g = smoothstep(0.3, 0.9, col.g);
    // col.b = smoothstep(0.5, 0.0, col.b);
    // col.b = smoothstep(0.0, 0.1, uv.x);

    
    gl_FragColor = vec4(col, 1.0);

}