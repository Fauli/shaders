#iChannel0 "file://xibalba.png"


void main() {
    vec2 uv = (gl_FragCoord.xy - 0.5 * iResolution.xy) / iResolution.y;

    float a = atan(uv.y, uv.x);
    float r = length(uv);

    vec2 st = vec2(a / 3.1415, 0.1 / r)
    +0.2 * iTime;
    
    vec3 col = texture(iChannel0, st).rgb;
    col *= 3.5 * r;

    gl_FragColor = vec4(col,1.0);
}