void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord / iResolution.xy;

    // Grid size
    float gridSizeX = 1.0 / 6.0; // 6 columns
    float gridSizeY = 1.0 / 4.0; // 4 rows

    // Calculate grid index
    int gridX = int(uv.x / gridSizeX);
    int gridY = int(uv.y / gridSizeY);

    // Alternate colors
    if ((gridX + gridY) % 2 == 0) {
        fragColor = vec4(1.0, 0.0, 0.0, 1.0); // Red for even sum
    } else {
        fragColor = vec4(0.0, 1.0, 0.0, 1.0); // Green for odd sum
    }
}
