void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // Normalized pixel coordinates (from -1 to 1)
    vec2 uv = (gl_FragCoord.xy - 0.5 * iResolution.xy) / iResolution.y;

    // Flip y coordinate (ShaderToy's origin is bottom left)
    uv.y = -uv.y;

    // vec2 r = fract(uv * 3.0);

    // uv *= r;

    // not sure i I like this :D
    // uv *= abs(sin(iTime * 0.6) / 0.6) + 0.8;


    // Define the center and radius of the circle
    vec2 circleCenter = vec2(-0.2, -0.2); // Adjust for top-left corner
    float circleRadius = sin(iTime + 0.3) * 0.03 + 0.07; // Circle radius

    // Determine the distance from the current point to the circle's center
    float circleDist = distance(uv, circleCenter);

    // Define the center and radius of the half-circle
    vec2 halfCircleCenter = vec2(-0.054, 0.15); // Below the triangle
    float halfCircleRadius = 0.2; // Half-circle radius

    // Deform the half-circle1
    float deformation = sin(uv.x * 10.0 + iTime) * 0.06; // Example deformation

    // Determine the distance from the current point to the half-circle's center
    float halfCircleDist = distance(uv, halfCircleCenter) - deformation;

    // Draw a yellow circle in the top-left corner
    if (circleDist < circleRadius)
    {
        fragColor = vec4(1.0, 1.0, 0.0, 1.0); // Yellow color
    }
    else
    {
        // Triangle vertices with one corner at the top
        vec2 v0 = vec2(sin(uv.x * 10.0 + iTime) * 0.06 + 0.147, 0.15); // Lower left vertex
        vec2 v1 = vec2(-sin(uv.x * 10.0 + iTime) * 0.06 -0.255, 0.15);  // Lower right vertex
        vec2 v2 = vec2(0.0, -0.15);    // Top vertex

        // Barycentric coordinates for the triangle
        float alpha = ((uv.y - v1.y) * (v2.x - v1.x) - (uv.x - v1.x) * (v2.y - v1.y)) /
                      ((v0.y - v1.y) * (v2.x - v1.x) - (v0.x - v1.x) * (v2.y - v1.y));
        float beta = ((uv.y - v2.y) * (v0.x - v2.x) - (uv.x - v2.x) * (v0.y - v2.y)) /
                     ((v1.y - v2.y) * (v0.x - v2.x) - (v1.x - v2.x) * (v0.y - v2.y));
        float gamma = 1.0 - alpha - beta;

        // Check if inside the triangle
        if (alpha > 0.0 && beta > 0.0 && gamma > 0.0)
        {
            fragColor = vec4(1.0, 0.0, 0.0, 1.0); // Red color for the triangle
        }
        else if (halfCircleDist < halfCircleRadius && uv.y > halfCircleCenter.y)
        {
            fragColor = vec4(1.0, 1.0, 0.0, 1.0); // Yellow color for the deformed half-circle
        }
        else
        {
            fragColor = vec4(0.0, 0.0, 1.0, 1.0); // Blue background
        }
    }
}
