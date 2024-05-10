#ifdef GL_ES
precision highp float;
precision highp int;
#endif

uniform float time;
uniform vec2 resolution;
uniform float index;

// -1 = transparent, 0 = middle, 1 = opaque; apply gamma correction
vec4 bialpha(float bi) {
    float uni = bi / 2.0 + 0.5;
    float gammaCorrected = pow(uni, 1.0/2.2);
    return vec4(0, 0, 0, gammaCorrected);
}

void main() {
    vec2 uv = gl_FragCoord.xy / resolution.xy * 2.0 - 1.0;
    gl_FragColor = bialpha(uv.x);
}
