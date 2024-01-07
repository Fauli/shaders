/*{
    "CATEGORIES": [
        "color"
    ],
    "CREDIT": "",
    "DESCRIPTION": "color switching checkers board",
    "INPUTS": [
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
            "NAME": "columns",
            "TYPE": "float"
        },
        {
            "DEFAULT": 1,
            "MAX": 20,
            "MIN": 1,
            "NAME": "speed",
            "TYPE": "float"
        }
    ],
    "ISFVSN": "2"
}
*/

void main() {
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = gl_FragCoord.xy / RENDERSIZE.xy;

    // Grid size
    float gridSizeX = 1.0 / columns; // 6 columns
    float gridSizeY = 1.0 / rows; // 4 rows

    // Calculate grid index
    int gridX = int(uv.x / gridSizeX);
    int gridY = int(uv.y / gridSizeY);

    // Time-dependent component
    float time = mod(TIME * speed, 2.0 * 3.14159); // Repeat every ~2π seconds

    // Alternate colors with time
    float colorFactor = sin(time + float(gridX + gridY));
    vec3 color = 0.5 + 0.5 * cos(time + vec3(0.0, 2.0, 4.0) + float(gridX + gridY));

    // Assign the color
    gl_FragColor = vec4(color, 1.0);
}
