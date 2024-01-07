/*{
    "CATEGORIES": [
        "color"
    ],
    "CREDIT": "",
    "DESCRIPTION": "color switching checkers board",
    "INPUTS": [
            {
            "DEFAULT": [
                0.2,
                0.2,
                0.6,
                1
            ],
            "LABEL": "Color of the snake",
            "NAME": "snakeColor",
            "TYPE": "color"
        },
        {
            "DEFAULT": [
                1,
                0,
                0,
                1
            ],
            "LABEL": "Color One Start",
            "NAME": "colorOneStart",
            "TYPE": "color"
        },
        {
            "DEFAULT": [
                0,
                1,
                0,
                1
            ],
            "LABEL": "Color Two Start",
            "NAME": "colorTwoStart",
            "TYPE": "color"
        },
        {
            "DEFAULT": [
                0,
                0,
                1,
                1
            ],
            "LABEL": "Color One End",
            "NAME": "colorOneEnd",
            "TYPE": "color"
        },
        {
            "DEFAULT": [
                0.5,
                0,
                0.5,
                1
            ],
            "LABEL": "Color Two End",
            "NAME": "colorTwoEnd",
            "TYPE": "color"
        },
        {
            "DEFAULT": 4,
            "MAX": 10,
            "MIN": 1,
            "NAME": "rows",
            "TYPE": "float"
        },
        {
            "DEFAULT": 6,
            "MAX": 10,
            "MIN": 1,
            "NAME": "cols",
            "TYPE": "float"
        },
        {
            "DEFAULT": 1,
            "MAX": 10,
            "MIN": 1,
            "NAME": "speed",
            "TYPE": "float"
        },
        {
            "DEFAULT": 4,
            "MAX": 10,
            "MIN": 1,
            "NAME": "snakeSpeed",
            "TYPE": "float"
        },
        {
            "DEFAULT": 6,
            "MAX": 10,
            "MIN": 1,
            "NAME": "snakeLength",
            "TYPE": "float"
        }
    ],
    "ISFVSN": "2"
}
*/

void main() {
    // UV coordinates
    vec2 uv = gl_FragCoord.xy / RENDERSIZE.xy;

    // Grid size
    float gridSizeX = 1.0 / cols;
    float gridSizeY = 1.0 / rows;

    // Calculate grid index
    int gridX = int(uv.x / gridSizeX);
    int gridY = int(uv.y / gridSizeY);

    // Time-dependent factors for color change
    float timeFactor1 = (sin(TIME * speed) + 1.0) / 2.0;
    float timeFactor2 = (sin(TIME * speed + 3.14159) + 1.0) / 2.0;

    // Base and target colors
    vec4 baseColor1 = vec4(colorOneStart); // Red
    vec4 baseColor2 = vec4(colorTwoStart); // Green
    vec4 targetColor1 = vec4(colorOneEnd); // Green (for red squares)
    vec4 targetColor2 = vec4(colorTwoEnd); // Purple (for green squares)

    // Interpolate colors
    vec4 color1 = mix(baseColor1, targetColor1, timeFactor1);
    vec4 color2 = mix(baseColor2, targetColor2, timeFactor2);

    // Snake logic
    bool isSnakeCell = false;

    // Loop over the length of the snake
    for (int i = 0; i < int(snakeLength); ++i) {
        float snakeTime = mod(TIME * snakeSpeed - float(i), 20.0);

        // Define the path of the snake for each segment
        if (snakeTime < 6.0) {
            // Top row, left to right
            isSnakeCell = isSnakeCell || (gridY == 0 && gridX == int(snakeTime));
        } else if (snakeTime < 10.0) {
            // Right column, top to bottom
            isSnakeCell = isSnakeCell || (gridX == int(cols)-1 && gridY == int(snakeTime - 6.0));
        } else if (snakeTime < 16.0) {
            // Bottom row, right to left
            isSnakeCell = isSnakeCell || (gridY == int(rows)-1 && gridX == 5 - int(snakeTime - 10.0));
        } else {
            // Left column, bottom to top
            isSnakeCell = isSnakeCell || (gridX == 0 && gridY == 3 - int(snakeTime - 16.0));
        }
    }

    // Set color
    if (isSnakeCell) {
        gl_FragColor = vec4(snakeColor); // Snake color (yellow here)
    } else if (mod(float(gridX + gridY), 2.0) == 0.0) {
        gl_FragColor = color1;
    } else {
        gl_FragColor = color2;
    }
}
