// Noise function for added complexity
float noise(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // UV coordinates
    vec2 uv = fragCoord / iResolution.xy;

    // Grid size
    float gridSizeX = 1.0 / 6.0;
    float gridSizeY = 1.0 / 4.0;

    // Calculate grid index
    int gridX = int(uv.x / gridSizeX);
    int gridY = int(uv.y / gridSizeY);

    // Dynamic wave properties
    float time = iTime * 0.7;
    float waveFrequencyX = 0.2 + sin(time * 0.1) * 0.5;
    float waveFrequencyY = 0.3 + cos(time * 0.15) * 0.5;
    float waveAmplitude = 0.5;

    // Calculate wave effects
    float waveX = sin(float(gridX) * waveFrequencyX + time);
    float waveY = cos(float(gridY) * waveFrequencyY + time);
    float combinedWave = (waveX + waveY) * waveAmplitude * 0.5;

    // Noise for extra randomness
    float n = noise(uv * 10.0 + time);

    // Color variation
    vec3 color1 = vec3(0.2, 0.6, 1.0); // Blue
    vec3 color2 = vec3(1.0, 0.6, 0.2); // Orange
    vec3 color = mix(color1, color2, combinedWave + n * 0.5);

    fragColor = vec4(color, 1.0);
}
