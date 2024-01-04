void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // Normalized pixel coordinates (from -1 to 1)
    vec2 uv = (fragCoord - iResolution.xy * 0.5) / iResolution.y;
    vec2 uv0 = (fragCoord.xy / iResolution.xy);

    // Angle of rotation
    float angle = iTime * 0.5;

    // Rotation matrix
    mat2 rot = mat2(cos(angle), -sin(angle),
                    sin(angle), cos(angle));

    // Rotate the coordinates
    uv = rot * uv;

    // Example: simple shape (circle)
    float radius = 0.2;
    float deformation = sin(uv.x * 10.0 * iTime / 30.) * 0.08; // Example deformation

    float dist = length(uv) - deformation;
    vec3 col = (dist < radius) ? vec3(1.0, 0.5, 0.2) : vec3(0.0);


    col *= 1.0 - dist / radius;

    col *= uv0.yxy * 4.0;
    col *= 1.0 - length(uv0) * 0.6;



    // Output to screen
    fragColor = vec4(col, 1.0);
}
