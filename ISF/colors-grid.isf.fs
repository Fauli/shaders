/*{
    "CATEGORIES": [
        "color"
    ],
    "CREDIT": "",
    "DESCRIPTION": "color switching checkers board",
    "INPUTS": [
        {
            "DEFAULT": [
                1,
                0,
                0,
                1
            ],
            "NAME": "colorOneStart",
            "TYPE": "color",
            "LABEL": "Color One Start"
        },
        {
            "DEFAULT": [
                0,
                1,
                0,
                1
            ],
            "NAME": "colorTwoStart",
            "TYPE": "color",
            "LABEL": "Color Two Start"
        },
        {
            "DEFAULT": [
                0,
                0,
                1,
                1
            ],
            "NAME": "colorOneEnd",
            "TYPE": "color",
            "LABEL": "Color One End"
        },
        {
            "DEFAULT": [
                0.5,
                0,
                0.5,
                1
            ],
            "NAME": "colorTwoEnd",
            "TYPE": "color",
            "LABEL": "Color Two End"
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
            "NAME": "columns",
            "TYPE": "float"
        },
        {
            "DEFAULT": 1,
            "MAX": 10,
            "MIN": 1,
            "NAME": "speed",
            "TYPE": "float"
        }
    ],
    "ISFVSN": "2"
}
*/

void main() {
    // Updated UV coordinates
    vec2 uv = (gl_FragCoord.xy - RENDERSIZE.xy) / RENDERSIZE.y;

    // Grid size
    float gridSizeX = 1.0 / float(columns); // 6 columns
    float gridSizeY = 1.0 / float(rows); // 4 rows

    // Calculate grid index
    int gridX = int(uv.x / gridSizeX);
    int gridY = int(uv.y / gridSizeY);

    // Time-dependent interpolation factors with offset
    float timeFactor1 = (sin(TIME * speed) + 1.0) / 2.0; // Oscillates between 0 and 1
    float timeFactor2 = (sin(TIME * speed + 3.14159) + 1.0) / 2.0; // Offset by π radians (half cycle)

    // Define base colors
    vec4 baseColor1 = vec4(colorOneStart); // Red
    vec4 baseColor2 = vec4(colorTwoStart); // Green

    // Define target colors
    vec4 targetColor1 = vec4(colorOneEnd); // Green (for red squares)
    vec4 targetColor2 = vec4(colorTwoEnd); // Purple (for green squares)

    // Interpolate between colors
    vec4 color1 = mix(baseColor1, targetColor1, timeFactor1);
    vec4 color2 = mix(baseColor2, targetColor2, timeFactor2);

    // Alternate colors with offset
    if (mod(float(gridX + gridY), 2.0) == 0.0) {
        gl_FragColor = color1;
    } else {
        gl_FragColor = color2;
    }
}
