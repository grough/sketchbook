#ifdef GL_ES
precision highp float;
precision highp int;
#endif

uniform float time;
uniform float seed;
uniform vec2 resolution;
uniform float start;
uniform float rotations;
uniform float hue;
uniform float gamma;

const float PI = 3.1415926535897932384626433832795;

vec4 cubehelix(float x) {
    float angle = 2 * PI * (start / 3.0 + 1 + rotations * x);
    x = pow(x, gamma);
    float amp = hue * x * (1 - x) / 2.0;
    float r = x + amp * (-0.14861 * cos(angle) + 1.78277 * sin(angle));
    float g = x + amp * (-0.29227 * cos(angle) - 0.90649 * sin(angle));
    float b = x + amp * (1.97294 * cos(angle));
    return vec4(max(min(r, 1.0), 0.0), max(min(g, 1.0), 0.0), max(min(b, 1.0), 0.0), 1.0);
}

void main() {
    float rand = fract(sin(dot(gl_FragCoord.xy + time, vec2(12.9898,78.233))) * seed);

//    gl_FragColor = cubehelix(gl_FragCoord.x / resolution.x);
    gl_FragColor = vec4(time / 4.0, 1, 1, 1);
}

