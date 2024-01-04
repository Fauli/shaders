/*{
    "CATEGORIES": [
        "colors"
    ],
    "CREDIT": "",
    "DESCRIPTION": "Fancy Color from the center",
    "INPUTS": [
        {
            "DEFAULT": 0.5,
            "MAX": 5,
            "MIN": 0,
            "NAME": "redPart",
            "TYPE": "float"
        },
        {
            "DEFAULT": 2,
            "MAX": 5,
            "MIN": 0,
            "NAME": "greenPart",
            "TYPE": "float"
        },
        {
            "DEFAULT": 4,
            "MAX": 6,
            "MIN": 0,
            "NAME": "bluePart",
            "TYPE": "float"
        },
        {
            "DEFAULT": 0.5,
            "MAX": 5,
            "MIN": 0,

            "NAME": "speed",
            "TYPE": "float"
        }
    ],
    "ISFVSN": "2"
}
*/

void main() {
    // Normalized pixel coordinates (from 0 to 1), with origin at the center
    vec2 uv = (gl_FragCoord.xy - 0.5 * RENDERSIZE.xy) / RENDERSIZE.y;

    // Time variable for the moving effect
    float time = TIME * speed;

    // Adjust UV coordinates to start from the middle
    uv.y += 0.5;

    // fun thing to do:
    // uv = fract(uv * sin(iTime * 0.5) * 5.0);

    // Check if we are in the top half of the canvas
    bool isTopHalf = uv.y > 0.5;

    // If in the top half, flip the y-coordinate
    if (isTopHalf) {
        uv.y = 1.0 - uv.y;
    }

    // Calculate the vertical position from the center, including the downward movement
    float y = uv.y + time;

    // Create a repeating vertical gradient to simulate the waterfall
    float gradient = mod(y, 1.0);

    // Customizable color component relations
    float r = redPart; // Customize red component relation
    float g = greenPart; // Customize green component relation
    float b = bluePart; // Customize blue component relation

    // Generate a customizable rainbow color based on the gradient
    vec3 color = 0.5 + 0.5 * sin(gradient * 6.28318 + vec3(r, g, b));

    // Set the color of the pixel
    gl_FragColor = vec4(color, 1.0);
}
