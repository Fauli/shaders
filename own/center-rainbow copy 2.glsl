// ShaderToy GLSL code with Customizable Rainbow Waterfall Colors

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Normalized pixel coordinates (from 0 to 1), with origin at the center
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    // Time variable for the moving effect
    float time = iTime * 0.2;    
    
    //uv = fract(uv * sin(iTime * 0.5) * 8.0);
    
    float a = atan(uv.y, uv.x);
    float rad = length(uv);

    vec2 st = vec2(a / 3.1415, 0.3 / rad) +0.2 * iTime;

    // Check if we are in the top half of the canvas

    // If in the top half, flip the y-coordinate

    st *= 5.;
    
    uv += st;


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


/* trippy center:
// ShaderToy GLSL code with Customizable Rainbow Waterfall Colors

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Normalized pixel coordinates (from 0 to 1), with origin at the center
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;

    // Time variable for the moving effect
    float time = iTime * 0.2;

    // Adjust UV coordinates to start from the middle
    
    
    //uv = fract(uv * sin(iTime * 0.5) * 8.0);
    
    float a = atan(uv.x, uv.y);
    float rad = length(uv);

    vec2 st = vec2(a / 3.1415, 0.1 / rad) +0.1 * iTime;

    // Check if we are in the top half of the canvas

    // If in the top half, flip the y-coordinate

    st *= 20.;
    

    
    uv += st;


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
*/