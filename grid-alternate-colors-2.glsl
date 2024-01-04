void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Updated UV coordinates
    vec2 uv = (fragCoord.xy - iResolution.xy) / iResolution.y;

        for (int i = 1; i < 10; i++) {
        float power = float(i) * 3.0;
        uv.x += 0.2 / power * sin(power * uv.y + iTime);
        uv.y += 0.3 / power * cos(power * uv.x + iTime);
    }

    // Grid size
    float gridSizeX = 1.0 / 6.0; // 6 columns
    float gridSizeY = 1.0 / 4.0; // 4 rows

    // Calculate grid index
    int gridX = int(uv.x / gridSizeX);
    int gridY = int(uv.y / gridSizeY);

    // Time-dependent interpolation factors with offset
    float timeFactor1 = (sin(iTime) + 1.0) / 2.0; // Oscillates between 0 and 1
    float timeFactor2 = (sin(iTime + 3.14159) + 1.0) / 2.0; // Offset by π radians (half cycle)

    // Define base colors
    vec4 baseColor1 = vec4(1.0, 0.0, 0.0, 1.0); // Red
    vec4 baseColor2 = vec4(0.0, 1.0, 0.0, 1.0); // Green

    // Define target colors
    vec4 targetColor1 = vec4(0.0, 0.0, 1.0, 1.0); // Green (for red squares)
    vec4 targetColor2 = vec4(0.5, 0.0, 0.5, 1.0); // Purple (for green squares)

    // Interpolate between colors
    vec4 color1 = mix(baseColor1, targetColor1, timeFactor1);
    vec4 color2 = mix(baseColor2, targetColor2, timeFactor2);

    // Alternate colors with offset
    if ((gridX + gridY) % 2 == 0) {
        fragColor = color1;
    } else {
        fragColor = color2;
    }
}
