void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord / iResolution.xy;

    // Grid size
    float gridSizeX = 1.0 / 6.0; // 6 columns
    float gridSizeY = 1.0 / 4.0; // 4 rows

    // Calculate grid index
    int gridX = int(uv.x / gridSizeX);
    int gridY = int(uv.y / gridSizeY);

    // Time-dependent component
    float time = mod(iTime, 2.0 * 3.14159); // Repeat every ~2π seconds

    // Alternate colors with time
    float colorFactor = sin(time + float(gridX + gridY));
    vec3 color = 0.5 + 0.5 * cos(time + vec3(0.0, 2.0, 4.0) + float(gridX + gridY));

    // Assign the color
    fragColor = vec4(color, 1.0);
}
