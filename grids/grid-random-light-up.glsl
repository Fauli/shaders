// Pseudo-random function
float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Corrected UV coordinates
    vec2 uv = fragCoord / iResolution.xy;

    // Grid size
    float gridSizeX = 1.0 / 6.0; // 6 columns
    float gridSizeY = 1.0 / 4.0; // 4 rows

    // Calculate grid index
    int gridX = int(uv.x / gridSizeX);
    int gridY = int(uv.y / gridSizeY);

    // Generate a random position every second
    float randomChangeInterval = 1.0;
    int randomSeed = int(iTime / randomChangeInterval);
    vec2 randomPos = vec2(rand(vec2(randomSeed, 0.1)), rand(vec2(randomSeed, 0.2)));
    int randomX = int(randomPos.x * 6.0);
    int randomY = int(randomPos.y * 4.0);

    // Check if the current square is the chosen one
    bool isChosenSquare = (gridX == randomX) && (gridY == randomY);

    // Light up the chosen square
    fragColor = isChosenSquare ? vec4(1.0, 1.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
}
