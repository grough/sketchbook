#ifdef GL_ES
precision highp float;
precision highp int;
#endif

uniform vec2 resolution;
uniform float uStart;
uniform float uRotations;
uniform float uHue;
uniform float uGamma;
uniform float[512] sound;
uniform int soundLength;

const float PI = 3.1415926535897932384626433832795;

vec4 cubehelix(float x, float start, float rotations, float hue, float gamma) {
    float angle = 2 * PI * (start / 3.0 + 1 + rotations * x);
    x = pow(x, gamma);
    float amp = hue * x * (1 - x) / 2.0;
    float r = x + amp * (-0.14861 * cos(angle) + 1.78277 * sin(angle));
    float g = x + amp * (-0.29227 * cos(angle) - 0.90649 * sin(angle));
    float b = x + amp * (1.97294 * cos(angle));
    return vec4(max(min(r, 1.0), 0.0), max(min(g, 1.0), 0.0), max(min(b, 1.0), 0.0), 1.0);
}

void main() {
    vec2 uv = gl_FragCoord.xy / resolution.xy * 2.0 - 1.0;
    float d = length(uv);
    int index = int(d * soundLength);
    if (index >= soundLength) {
        index = soundLength - 1;
    }
    
    float s = sound[index];
    gl_FragColor = cubehelix(1 - length(uv), uStart + s, uRotations, uHue, uGamma);
}

