void main() {
    vec2 uv = gl_FragCoord.xy / iResolution.xy;

    // uv = fract(uv * 2.0);
    float f = sin(iTime * 0.8) * 0.5 + 0.6;

    uv = mat2(cos(iTime * 0.1), -sin(iTime * 0.1), sin(iTime * 0.1), cos(iTime * 0.1)) * uv;
    vec3 col = vec3(f - uv.y, f+ -uv.y, 0. );

    col.r = smoothstep(0.0, 0.1, col.r);
    col.g = smoothstep(0.1, 0.0, col.g);
    col.b = smoothstep(0.2, 0.3, col.b);


    gl_FragColor = vec4(col, 1.0);
}