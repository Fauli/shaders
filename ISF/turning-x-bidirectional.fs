/*{
    "CATEGORIES": [
        "simple",
        "white"
    ],
    "CREDIT": "",
    "DESCRIPTION": "A turning white X",
    "INPUTS": [
        {
            "DEFAULT": 0.25,
            "MAX": 1,
            "MIN": 0.001,
            "NAME": "maxRotationSpeed",
            "TYPE": "float"
        },
        {
            "DEFAULT": false,
            "NAME": "changeDirection",
            "TYPE": "bool"
        },
        {
            "DEFAULT": 0.05,
            "MAX": 0.200,
            "MIN": 0.001,
            "NAME": "lineWidth",
            "TYPE": "float"
        },
        {
            "DEFAULT": 0.1,
            "MAX": 5,
            "MIN": 0.01,
            "NAME": "glowWidth",
            "TYPE": "float"
        }
    ],
    "ISFVSN": "2"
}
*/


void main()
{

    // Normalizing the pixel coordinates
    vec2 uv = (gl_FragCoord.xy - 0.5 * RENDERSIZE.xy) / RENDERSIZE.y;

    // Time-dependent rotation
    float time = TIME;

    float rotationSpeed = -1.0;
    if (changeDirection) {
    // Use a sinusoidal function to smoothly transition the rotation direction
       rotationSpeed = maxRotationSpeed * sin(time * 0.5);
    }

    // Calculate rotation angle
    float angle = rotationSpeed * time;

    // Rotation matrix
    mat2 rot = mat2(cos(angle), -sin(angle),
                    sin(angle),  cos(angle));
    
    // Apply rotation
    uv = rot * uv;

    // Calculate the distance to the center line of the X
    float d1 = abs(uv.x - uv.y);
    float d2 = abs(uv.x + uv.y);

    // Check if the pixel is close enough to either line of the X and apply glow
    float alpha = smoothstep(lineWidth, glowWidth, d1) * smoothstep(lineWidth, glowWidth, d2);
    gl_FragColor = mix(vec4(1.0), vec4(0.0, 0.0, 0.0, 1.0), alpha); // blend between white and black}
}