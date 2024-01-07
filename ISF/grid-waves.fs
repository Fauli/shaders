/*{
    "CATEGORIES": [
        "color"
    ],
    "CREDIT": "",
    "DESCRIPTION": "color switching checkers board",
    "INPUTS": [
        {
            "DEFAULT": [
                0,
                0.3,
                0.6,
                1
            ],
            "NAME": "color",
            "TYPE": "color",
            "LABEL": "Base Color"
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
    // UV coordinates
    vec2 uv = gl_FragCoord.xy / RENDERSIZE.xy;

    // Grid size
    float gridSizeX = 1.0 / columns;
    float gridSizeY = 1.0 / rows;

    // Calculate grid index
    int gridX = int(uv.x / gridSizeX);
    int gridY = int(uv.y / gridSizeY);

    // Wave properties
    float waveFrequencyX = 1.0; // Frequency of the wave along X axis
    float waveFrequencyY = 2.0; // Frequency of the wave along Y axis
    float waveAmplitude = 0.7; // Amplitude of the wave
    float waveSpeed = 2.0; // Speed of the wave

    // Calculate wave effect
    float waveX = sin(float(gridX) * waveFrequencyX + TIME * waveSpeed) * waveAmplitude;
    float waveY = sin(float(gridY) * waveFrequencyY + TIME * waveSpeed) * waveAmplitude;

    // Combine X and Y wave effects
    float combinedWave = (waveX + waveY) * 0.5;

    // Base color (ocean blue)
    vec4 baseColor = vec4(color);

    // Apply wave effect to color brightness
    float brightness = 0.5 + 0.5 * combinedWave;
    vec4 waveColor = baseColor * brightness;

    gl_FragColor = waveColor;
}
