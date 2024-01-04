// ShaderToy GLSL code with Customizable Rainbow Waterfall Colors

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Normalized pixel coordinates (from 0 to 1), with origin at the center
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    // Time variable for the moving effect
    float time = iTime * 0.5;

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
    float r = 0.5; // Customize red component relation
    float g = 2.0; // Customize green component relation
    float b = 4.0; // Customize blue component relation

    // Generate a customizable rainbow color based on the gradient
    vec3 color = 0.5 + 0.5 * sin(gradient * 6.28318 + vec3(r, g, b));

    // Set the color of the pixel
    fragColor = vec4(color, 1.0);
}
