/*
{
  "CATEGORIES" : [
    "bars"
  ],
  "CREDIT": "",
  "ISFVSN" : "2",
  "INPUTS" : [
    {
      "NAME" : "width",
      "TYPE" : "float",
      "DEFAULT" : 0.25
    },
    {
      "NAME" : "offset",
      "TYPE" : "point2D",
      "DEFAULT" : [
        0,
        0
      ],
      "MIN" : [
      	0,
      	0
      ],
      "MAX" : [
      	1,
      	1
      ]
    },
    {
      "NAME" : "color1",
      "TYPE" : "color",
      "DEFAULT" : [
        1,
        1,
        1,
        1
      ]
    },
    {
      "NAME" : "color2",
      "TYPE" : "color",
      "DEFAULT" : [
        0,
        0,
        0,
        1
      ]
    },
    {
      "NAME" : "splitPos",
      "TYPE" : "point2D",
      "MAX" : [
        1,
        1
      ],
      "DEFAULT" : [
        0.5,
        0.5
      ],
      "MIN" : [
        0,
        0
      ]
    }
  ]
}
*/



// adapted from book of shaders
float fbm ( in vec2 _st) {
    float x = _st.x;
    float amplitude = 2.;  // Change for effect
    float frequency = 0.7;  // Change for effect
    float y = sin(x * frequency);
    float t = 0.01*(-TIME*130.0);
    y += sin(x*frequency*2.1 + t)*4.5;
    y += sin(x*frequency*1.72 + t*1.121)*4.0;
    y += sin(x*frequency*2.221 + t*0.437)*5.0;
    y += sin(x*frequency*3.1122+ t*4.269)*2.5;
    y *= amplitude*0.06;
    return y;
}

void main() {
    vec2 st = gl_FragCoord.xy/RENDERSIZE.xy*10.;
    vec3 color = vec3(0.0);

    vec2 q = vec2(0.);
    q.x = fbm( st + 0.00*TIME);

    vec2 r = vec2(0.);
    r.x = fbm( st + 1.0*q + vec2(1.7,9.2)+ 0.15*TIME);

    float f = fbm(st+r);

    color = mix(vec3(0.101961,0.619608,0.666667),
                vec3(0.666667,0.666667,0.498039),
                clamp((f*f)*4.0,0.0,1.0));

    color = mix(color,
                vec3(0,0,0.164706),
                clamp(length(q),0.0,1.0));

    color = mix(color,
                vec3(0.666667,1,1),
                clamp(length(r.x),0.0,1.0));

    gl_FragColor = vec4((f*f*f+.6*f*f+.5*f)*color,1.);
}
