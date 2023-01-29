import com.jogamp.opengl.GLProfile;
{
  GLProfile.initSingleton();
}

PShader myShader;

void setup() {
    size(600, 200, P2D);
    myShader = loadShader("test.glsl");
}

void draw() {
    myShader.set("resolution", width, height);
    shader(myShader);
    rect(0, 0, width, height);
}
