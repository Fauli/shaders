void main() {
    vec2 uv = (gl_FragCoord.xy / iResolution.xy) * 2.0 - 1.0;

    float line = sin(uv.x * 10.0 - 10.*sin(iTime) * 0.5) * sin(0.5 + iTime) + 0.7;

    float line2 = sin(uv.y * 10.0 - sin(iTime) * 0.5) * cos(0.5 + iTime) + 0.7;

    float line3 = sin(uv.x * 10.0 + uv.y * 10.0  - iTime) * tan(0.5 + iTime) + 0.7;

    vec4 col = vec4(line, line2, line3, 1.);

    gl_FragColor = col;
}