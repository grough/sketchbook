import com.jogamp.opengl.GLProfile;
{
  GLProfile.initSingleton();
}

PShader myShader;
MySoundFile wav;
float[] samples;

void setup() {
  size(720, 720, P2D);
  myShader = loadShader("shader.glsl");
  wav = new MySoundFile(this, "untitled.wav");
  samples = new float[256];
}

void draw() {
  float t = millis() / 1000.0;
  float w = sin(TWO_PI * t * 0.01);
  for (int i = 0; i < samples.length; i++) {
    samples[i] = wav.scan(i/float(samples.length), 1);
  }
  myShader.set("resolution", width, height);
  myShader.set("uStart", 0.5);
  myShader.set("uRotations", 1.0);
  myShader.set("uHue", 1.0);
  myShader.set("uGamma", 1.0);
  myShader.set("sound", samples);
  myShader.set("soundLength", samples.length);
  shader(myShader);
  rect(0, 0, width, height);
}
