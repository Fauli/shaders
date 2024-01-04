void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // UV coordinates
    vec2 uv = fragCoord / iResolution.xy;

    // Grid size
    float gridSizeX = 1.0 / 6.0;
    float gridSizeY = 1.0 / 4.0;

    // Calculate grid index
    int gridX = int(uv.x / gridSizeX);
    int gridY = int(uv.y / gridSizeY);

    // Wave properties
    float waveFrequencyX = 1.0; // Frequency of the wave along X axis
    float waveFrequencyY = 2.0; // Frequency of the wave along Y axis
    float waveAmplitude = 0.7; // Amplitude of the wave
    float waveSpeed = 2.0; // Speed of the wave

    // Calculate wave effect
    float waveX = sin(float(gridX) * waveFrequencyX + iTime * waveSpeed) * waveAmplitude;
    float waveY = sin(float(gridY) * waveFrequencyY + iTime * waveSpeed) * waveAmplitude;

    // Combine X and Y wave effects
    float combinedWave = (waveX + waveY) * 0.5;

    // Base color (ocean blue)
    vec4 baseColor = vec4(0.0, 0.3, 0.6, 1.0);

    // Apply wave effect to color brightness
    float brightness = 0.5 + 0.5 * combinedWave;
    vec4 waveColor = baseColor * brightness;

    fragColor = waveColor;
}
