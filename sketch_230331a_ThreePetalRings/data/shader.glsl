#ifdef GL_ES
precision highp float;
precision highp int;
#endif

uniform float time;
uniform vec2 resolution;
uniform float inner;
uniform float outer;
uniform float phase;

const float PI = 3.1415926535897932384626433832795;

void main() {
    vec2 uv = gl_FragCoord.xy / resolution.xy * 2.0 - 1.0;
    float d = length(uv);
    float angle = atan(uv.y, uv.x);
    float alpha = 0.0;
    
    float w = sin((angle + phase/8 + time) * 3);
    
    float dd = d + w/32;
    
    if (dd > inner && dd < outer) {
        alpha = 1;
    } else {
        alpha = 0;
    }
    
    gl_FragColor = vec4(0, 0, 0, alpha);
}
