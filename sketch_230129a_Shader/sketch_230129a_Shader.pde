import com.jogamp.opengl.GLProfile;
{
  GLProfile.initSingleton();
}

PShader myShader;

void setup() {
    size(720, 360, P2D);
    myShader = loadShader("test.glsl");
}

void draw() {
    float t = millis() / 1000.0;
    float w = sin(TWO_PI * t * 0.1);
    myShader.set("resolution", width, height);
    myShader.set("start", 0.5 + w * 4);
    myShader.set("rotations", 1.5);
    myShader.set("hue", 1.0);
    myShader.set("gamma", 1.0);
    shader(myShader);
    rect(0, 0, width, height);
}
