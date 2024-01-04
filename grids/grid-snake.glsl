void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // UV coordinates
    vec2 uv = fragCoord / iResolution.xy;

    // Grid size
    float gridSizeX = 1.0 / 6.0;
    float gridSizeY = 1.0 / 4.0;

    // Calculate grid index
    int gridX = int(uv.x / gridSizeX);
    int gridY = int(uv.y / gridSizeY);

    // Time-dependent factors for color change
    float timeFactor1 = (sin(iTime) + 1.0) / 2.0;
    float timeFactor2 = (sin(iTime + 3.14159) + 1.0) / 2.0;

    // Base and target colors
    vec4 baseColor1 = vec4(1.0, 0.0, 0.0, 1.0); // Red
    vec4 baseColor2 = vec4(0.0, 1.0, 0.0, 1.0); // Green
    vec4 targetColor1 = vec4(0.0, 1.0, 0.0, 1.0); // Green (for red squares)
    vec4 targetColor2 = vec4(0.5, 0.0, 0.5, 1.0); // Purple (for green squares)

    // Interpolate colors
    vec4 color1 = mix(baseColor1, targetColor1, timeFactor1);
    vec4 color2 = mix(baseColor2, targetColor2, timeFactor2);

    // Snake logic
    float snakeSpeed = 5.0; // Adjust the speed of the snake
    float snakeLength = 6.0; // Length of the snake
    bool isSnakeCell = false;

    // Loop over the length of the snake
    for (int i = 0; i < int(snakeLength); ++i) {
        float snakeTime = mod(iTime * snakeSpeed - float(i), 20.0);

        // Define the path of the snake for each segment
        if (snakeTime < 6.0) {
            // Top row, left to right
            isSnakeCell = isSnakeCell || (gridY == 0 && gridX == int(snakeTime));
        } else if (snakeTime < 10.0) {
            // Right column, top to bottom
            isSnakeCell = isSnakeCell || (gridX == 6-1 && gridY == int(snakeTime - 6.0));
        } else if (snakeTime < 16.0) {
            // Bottom row, right to left
            isSnakeCell = isSnakeCell || (gridY == 4-1 && gridX == 5 - int(snakeTime - 10.0));
        } else {
            // Left column, bottom to top
            isSnakeCell = isSnakeCell || (gridX == 0 && gridY == 3 - int(snakeTime - 16.0));
        }
    }

    // Set color
    if (isSnakeCell) {
        fragColor = vec4(0.2, 0.2, 0.6, 1.0); // Snake color (yellow here)
    } else if ((gridX + gridY) % 2 == 0) {
        fragColor = color1;
    } else {
        fragColor = color2;
    }
}
