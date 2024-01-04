/*
{
  "CATEGORIES" : [
    "grids"
  ],
  "CREDIT": "",
  "ISFVSN" : "2",
  "INPUTS" : [
           {
            "DEFAULT": 4,
            "MAX": 20,
            "MIN": 1,
            "NAME": "rows",
            "TYPE": "float"
        },
        {
            "DEFAULT": 6,
            "MAX": 20,
            "MIN": 1,
            "NAME": "columns",
            "TYPE": "float"
        },
        {
            "DEFAULT": 1,
            "MAX": 10,
            "MIN": 0.1,
            "NAME": "interval",
            "TYPE": "float"
        }
  ]
}
*/



// Pseudo-random function
float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    // Corrected UV coordinates
    vec2 uv = gl_FragCoord.xy / RENDERSIZE.xy;

    // Grid size
    float gridSizeX = 1.0 / columns; // 6 columns
    float gridSizeY = 1.0 / rows; // 4 rows

    // Calculate grid index
    int gridX = int(uv.x / gridSizeX);
    int gridY = int(uv.y / gridSizeY);

    // Generate a random position every second
    float randomChangeInterval = interval;
    int randomSeed = int(TIME / randomChangeInterval);
    vec2 randomPos = vec2(rand(vec2(randomSeed, 0.1)), rand(vec2(randomSeed, 0.2)));
    int randomX = int(randomPos.x * columns);
    int randomY = int(randomPos.y * rows);

    // Check if the current square is the chosen one
    bool isChosenSquare = (gridX == randomX) && (gridY == randomY);

    // Light up the chosen square
    gl_FragColor = isChosenSquare ? vec4(1.0, 1.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
}
