void main () {
    vec2 uv = (gl_FragCoord.xy * 2.0 - iResolution.xy) / iResolution.y;
    vec2 uv0 = uv;

        for (int i = 1; i < 8; i++) {
        float power = float(i) * 2.0;
        uv.x += 0.1 / power * sin(power * uv.y + iTime * 0.5);
        uv.y += 0.1 / power * cos(power * uv.x + iTime);
    }

    float mouse = iMouse.y;

    vec3 col = vec3(mouse);

    col *= uv.x * uv.y * 10.0;

    float d = length(uv);
    float r = 0.3 + 0.2 * sin(iTime);
    float a = atan(sin(uv.x * 3.1415), cos(uv.y * 3.1415 + iTime * 20.));
    float f = 0.0;
    if (d > r) {
        f = 1.0;
    }
    col *= f;

    col.r += 0.4 * sin(iTime);
    col.g += 0.3 * sin(iTime + 2.0);
    col.b += 0.4 * sin(iTime + 4.0);






    gl_FragColor = vec4(col, 1.0);
}