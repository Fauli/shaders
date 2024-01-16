void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    bool changeDirection = false;

    // Normalizing the pixel coordinates
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    // Time-dependent rotation
    float time = iTime;
    float maxRotationSpeed = 0.0003; // Maximum rotation speed

    float rotationSpeed = -1.0;
    if (changeDirection) {
    // Use a sinusoidal function to smoothly transition the rotation direction
       rotationSpeed = maxRotationSpeed * sin(time * 0.5);
    }

    // Calculate rotation angle
    // float angle = mod(rotationSpeed * time,6.28318530718);
    float angle = rotationSpeed * mod(time, 1000000.);

    // Rotation matrix
    mat2 rot = mat2(cos(angle), -sin(angle),
                    sin(angle),  cos(angle));
    
    // Apply rotation
    uv = rot * uv;

    // Define the width of the lines of the X
    float lineWidth = 0.05;
    float glowWidth = 0.1; // Width of the glow effect

    // Calculate the distance to the center line of the X
    float d1 = abs(uv.x - uv.y);
    float d2 = abs(uv.x + uv.y);

    // Check if the pixel is close enough to either line of the X and apply glow
    float alpha = smoothstep(lineWidth, glowWidth, d1) * smoothstep(lineWidth, glowWidth, d2);
    fragColor = mix(vec4(1.0), vec4(0.0, 0.0, 0.0, 1.0), alpha); // blend between white and black}
}