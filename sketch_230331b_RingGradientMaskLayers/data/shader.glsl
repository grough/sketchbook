#ifdef GL_ES
precision highp float;
precision highp int;
#endif

uniform float time;
uniform vec2 resolution;
uniform float inner;
uniform float outer;
uniform float phase;
uniform float index;

const float PI = 3.1415926535897932384626433832795;
const float TWO_PI = 3.1415926535897932384626433832795 * 2.0;

// phasor with frequency f
float modd(float x, float f) {
    return mod(x, 1 / f) * f;
}

float w(float t) {
//    return sin(TWO_PI * t) / 2.0 + 0.5;
    return sin(t) / 2.0 + 0.5;
}

// sigma with steepness k
float sig(float x, float k, float x0) {
  float L = 1;
//  float x0 = 0;
  return L / (1 + exp(-k * (x - x0)));
}

void main() {
    vec2 uv = gl_FragCoord.xy / resolution.xy * 2.0 - 1.0;
    vec2 uvp = gl_FragCoord.xy / resolution.xy;
    float d = length(uv);
    float angle = atan(uv.y, uv.x);
    float alpha = 0.0;
//    alpha = sig(uv.x, 8, -.5);
    alpha = pow(modd(d, pow(2, index)), 2.2);
    gl_FragColor = vec4(0, 0, 0, alpha);
}
